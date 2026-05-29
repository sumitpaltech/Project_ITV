###############################################################################
# TaskApp — Production Dockerfile (multi-stage)
# Stage 1: Composer dependencies   (throwaway)
# Stage 2: Frontend assets          (throwaway)
# Stage 3: Final production image   (lean)
###############################################################################

# ─── Stage 1: Composer install ───────────────────────────────────────────────
FROM composer:2 AS vendor

WORKDIR /app
COPY composer.json composer.lock ./
RUN composer install \
      --no-dev \
      --no-interaction \
      --no-scripts \
      --prefer-dist \
      --optimize-autoloader \
      --ignore-platform-reqs

# ─── Stage 2: Frontend build (if you ever add Vite/Mix) ─────────────────────
FROM node:20-alpine AS frontend

WORKDIR /app
COPY package*.json ./
RUN if [ -f package.json ]; then npm ci --production=false; fi
COPY . .
# Ensure public/build always exists so the COPY below never fails
RUN mkdir -p /app/public/build && if [ -f vite.config.js ]; then npm run build; fi

# ─── Stage 3: Production image ───────────────────────────────────────────────
FROM php:8.2-fpm-alpine AS production

LABEL maintainer="devops@taskapp.io"
LABEL description="TaskApp Laravel 10 — production image"

# Install system dependencies + PHP extensions
RUN apk add --no-cache \
      nginx \
      supervisor \
      curl \
      libpng-dev \
      libjpeg-turbo-dev \
      libzip-dev \
      icu-dev \
      freetype-dev \
      oniguruma-dev \
      mysql-client \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) \
      pdo_mysql \
      mbstring \
      zip \
      gd \
      intl \
      bcmath \
      opcache \
    && rm -rf /var/cache/apk/*

# OPcache production settings
RUN { \
      echo 'opcache.memory_consumption=128'; \
      echo 'opcache.interned_strings_buffer=16'; \
      echo 'opcache.max_accelerated_files=10000'; \
      echo 'opcache.revalidate_freq=0'; \
      echo 'opcache.validate_timestamps=0'; \
      echo 'opcache.enable_cli=1'; \
    } > /usr/local/etc/php/conf.d/opcache-prod.ini

# PHP production config
RUN { \
      echo 'upload_max_filesize=20M'; \
      echo 'post_max_size=25M'; \
      echo 'memory_limit=256M'; \
      echo 'max_execution_time=60'; \
      echo 'expose_php=Off'; \
      echo 'display_errors=Off'; \
      echo 'log_errors=On'; \
    } > /usr/local/etc/php/conf.d/app-prod.ini

# Create non-root user
RUN addgroup -g 1000 taskapp && \
    adduser -u 1000 -G taskapp -s /bin/sh -D taskapp

# Application directory
WORKDIR /var/www/html

# Copy application source
COPY --chown=taskapp:taskapp . .

# Copy Composer vendor from stage 1
COPY --from=vendor --chown=taskapp:taskapp /app/vendor ./vendor

# Copy frontend assets from stage 2 (directory always exists thanks to mkdir above)
COPY --from=frontend --chown=taskapp:taskapp /app/public/build ./public/build

# Nginx config
COPY docker/nginx.conf /etc/nginx/http.d/default.conf

# Supervisord config (manages nginx + php-fpm)
COPY docker/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Prepare storage & cache directories; make nginx/supervisord dirs writable as non-root
RUN mkdir -p \
      storage/framework/{sessions,views,cache/data} \
      storage/logs \
      bootstrap/cache \
      /run/nginx \
      /var/log/nginx \
    && chown -R taskapp:taskapp storage bootstrap/cache /run/nginx /var/log/nginx \
    && chmod -R 775 storage bootstrap/cache \
    && mkdir -p /var/lib/nginx/logs /var/lib/nginx/tmp/client_body \
                /var/lib/nginx/tmp/proxy /var/lib/nginx/tmp/fastcgi \
                /var/lib/nginx/tmp/uwsgi /var/lib/nginx/tmp/scgi \
    && chown -R taskapp:taskapp /var/lib/nginx \
    && sed -i 's|^user .*|# user directive removed — running as non-root (taskapp)|' /etc/nginx/nginx.conf \
    && sed -i 's|pid .*|pid /tmp/nginx.pid;|' /etc/nginx/nginx.conf

# Regenerate package discovery without dev deps (collision removed)
# Dummy APP_KEY lets artisan bootstrap; real key is injected at runtime via k8s secret
ENV APP_KEY="base64:YWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWE="
RUN rm -f bootstrap/cache/packages.php bootstrap/cache/services.php \
      bootstrap/cache/config.php bootstrap/cache/routes*.php \
    && find storage/framework/views -name "*.php" -delete 2>/dev/null || true \
    && php artisan package:discover --ansi \
    && php artisan config:clear \
    && php artisan route:clear \
    && php artisan view:clear
ENV APP_KEY=""

# Health check
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
    CMD curl -f http://localhost:80/health || exit 1

EXPOSE 80

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
