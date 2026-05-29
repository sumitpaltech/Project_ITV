# TaskApp — Laravel Edition

This is a 1-to-1 Laravel 10 port of the Python/Flask **3IdeaTask** application.

It keeps:

* the same MySQL database (`3IdeaTask`) and the same two tables (`users`, `task_tracker`)
* the same login, register (admin-only), logout flow
* the same role logic — **admin** sees everything, **department head** sees their department, **normal user** sees only tasks assigned to them
* the same task index / create / edit / show pages, with the same filters and pagination
* the same file attachments (single replace + append-with-semicolons)
* the same Excel bulk import
* the same UI assets (Bootstrap, Tabler icons, ApexCharts, the whole `static/assets/` folder)

---

## 1. Server requirements

| What         | Version                          |
|--------------|----------------------------------|
| PHP          | 8.1 or higher                    |
| Composer     | 2.x                              |
| MySQL/MariaDB| 5.7+ / 10.4+                     |
| PHP exts     | `pdo_mysql`, `mbstring`, `openssl`, `tokenizer`, `xml`, `ctype`, `json`, `bcmath`, `fileinfo`, `gd` or `imagick`, `zip` |

> The `zip` and `gd` extensions are needed by `phpoffice/phpspreadsheet` for the Excel import.

---

## 2. Step-by-step installation

```bash
# 1. Put the project somewhere on your server
cd /var/www
unzip laravel-task.zip       # or git clone …
cd laravel-task

# 2. Install PHP dependencies
composer install

# 3. Copy the env file and generate an app key
cp .env.example .env
php artisan key:generate

# 4. (Optional) edit .env if your DB host / user / pass differs from the defaults.
#    The defaults match the Python project's .env:
#       DB_DATABASE=3IdeaTask
#       DB_USERNAME=bwr_user
#       DB_PASSWORD=BWR@Pass2026
nano .env

# 5. Bring your old data over OR migrate fresh
#    Option A — Keep your existing 3IdeaTask data (recommended if the DB already exists):
#       The two table schemas are identical, you do NOT need to migrate.
#
#    Option B — Fresh database:
php artisan migrate
php artisan db:seed --class=DemoUserSeeder

# 6. Copy the front-end assets from the Python project to Laravel's public folder
#    (Blade views reference asset('assets/…') so the path stays identical.)
cp -r /path/to/python/task/static/assets   public/assets
cp -r /path/to/python/task/static/uploads  public/uploads     # only if you want to keep existing attachments

# 7. Permissions
sudo chown -R www-data:www-data storage bootstrap/cache public/uploads
sudo chmod -R 775 storage bootstrap/cache public/uploads

# 8. Run it
php artisan serve --host=0.0.0.0 --port=7001
#    Same port as the Python app — http://192.168.3.223:7001
```

For production, point Apache / Nginx at `public/` and `mod_rewrite` (Apache) or
`try_files` (Nginx) will pick up the included `.htaccess`.

---

## 3. Login

If you ran `php artisan db:seed --class=DemoUserSeeder` step 5B:

| Field    | Value           |
|----------|-----------------|
| Username | `Sumit`         |
| Password | `password123`   |
| Role     | admin           |
| Dept.    | Admin           |

If you kept your existing `3IdeaTask` data (step 5A), use any account that
already exists in your `users` table. **Important:** the Python app hashed
passwords with `werkzeug.security.generate_password_hash` (PBKDF2-SHA256),
which Laravel's `Hash::check` does **not** understand. So:

* old users created by the Flask app will **not** be able to log in directly
* the easiest path is to log in as the admin (`Sumit`) created by the seeder
  and use the **Register User** screen to recreate any accounts you still
  need, OR run a one-off script to rehash:

```php
// php artisan tinker
use Illuminate\Support\Facades\Hash;
use App\Models\User;

// Example: reset every user to a temporary password
User::all()->each(function($u){
    $u->password = Hash::make('temp1234');
    $u->save();
});
```

---

## 4. Where everything lives — Python → Laravel map

| Python (Flask)                                  | Laravel                                          |
|-------------------------------------------------|--------------------------------------------------|
| `app.py` / `run.py`                             | `public/index.php` + `artisan serve`             |
| `config/config.py`                              | `.env` + `config/*.php`                          |
| `config/department.py`                          | `config/departments.php`                         |
| `app/__init__.py` (blueprint registration)      | `routes/web.php`                                 |
| `app/controllers/auth_controller.py`            | `app/Http/Controllers/AuthController.php`        |
| `app/controllers/dashboard_controller.py`       | `app/Http/Controllers/DashboardController.php`   |
| `app/controllers/task_controller.py`            | `app/Http/Controllers/TaskController.php`        |
| `app/middleware/auth_middleware.py`             | `app/Http/Middleware/EnsureAuthenticated.php`, `RedirectIfAuthenticated.php`, `EnsureAdmin.php` |
| `app/models/user_model.py`                      | `app/Models/User.php`                            |
| `app/models/task_model.py`                      | `app/Models/Task.php`                            |
| `app/views/templates/layouts/base.html`         | `resources/views/layouts/base.blade.php`         |
| `app/views/templates/auth/*.html`               | `resources/views/auth/*.blade.php`               |
| `app/views/templates/dashboard/*.html`          | `resources/views/dashboard/*.blade.php`          |
| `app/views/templates/tasks/*.html`              | `resources/views/tasks/*.blade.php`              |
| `static/assets/`                                | `public/assets/`                                 |
| `static/uploads/`                               | `public/uploads/`                                |
| `database/schema.sql`                           | `database/migrations/*.php`                      |

Route names are the same as the Flask `url_for()` names:
`auth.login`, `auth.logout`, `auth.register`, `dashboard.index`,
`dashboard.users`, `dashboard.department`, `dashboard.user_tasks`,
`task.index`, `task.create`, `task.store`, `task.show`, `task.edit`,
`task.update`, `task.delete`, `task.upload_file`, `task.upload_file_index`,
`task.download`, `task.import`.

---

## 5. Department heads

Edit `config/departments.php`. The structure is:

```php
'heads' => [
    'Department Name' => 'username_of_the_head',
    …
],
```

A user becomes a department head automatically when:
1. they log in,
2. their `users.department` field equals one of the keys in this array,
3. their `users.username` equals the value mapped to that key.

There's no extra flag or table — it's purely config-driven, exactly like
the Python project.

---

## 6. Excel import format

Columns, **in this exact order**, starting from column A:

1. title
2. description
3. category
4. department
5. assigned_to
6. team_member
7. user_mail
8. priority    (low / medium / high)
9. start_date  (any normal date format)
10. due_date
11. completion_date
12. status     (pending / in_progress / completed / cancelled)
13. remarks

The first row is treated as a header **if and only if** cell A1 literally
contains `title` — otherwise every row is imported. This matches the Python
behaviour.

---

## 7. Common errors

* **`SQLSTATE[HY000] [1045] Access denied`** — wrong `DB_USERNAME` / `DB_PASSWORD`. Update `.env`, then `php artisan config:clear`.
* **Old users can't log in** — see the password-rehash note in section 3.
* **Assets 404 (CSS / JS missing)** — you forgot step 6. Copy `static/assets/` to `public/assets/`.
* **`The stream or file "storage/logs/laravel.log" could not be opened`** — `chown -R www-data:www-data storage bootstrap/cache`.
