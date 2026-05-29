<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class DemoUserSeeder extends Seeder
{
    /**
     * Creates a working admin user.
     *
     * Default credentials:
     *    username : Sumit
     *    password : password123
     *
     * "Sumit" is set as the head of the "Admin" department in config/departments.php.
     */
    public function run(): void
    {
        User::updateOrCreate(
            ['username' => 'Sumit'],
            [
                'name'       => 'Sumit Pal',
                'email'      => 'sumit@example.com',
                'password'   => Hash::make('password123'),
                'role'       => 'admin',
                'department' => 'Admin',
                'status'     => 1,
            ]
        );

        $this->command->info('Admin user ready  →  username: Sumit  /  password: password123');
    }
}
