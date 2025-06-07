FROM php:8.2-fpm

ARG user=laravel
ARG uid=1000

RUN apt-get update && apt-get install -y \
    git curl libpng-dev libonig-dev libxml2-dev zip unzip sqlite3 libsqlite3-dev

RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd pdo_sqlite

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN useradd -G www-data,root -u $uid -d /home/$user $user
RUN mkdir -p /home/$user/.composer && chown -R $user:$user /home/$user

WORKDIR /var/www

COPY . .

RUN chown -R $user:$user /var/www

USER $user

RUN if [ ! -f .env ]; then cp .env.example .env; fi

ENTRYPOINT ["sh", "-c", "composer install && php artisan key:generate && php-fpm"]