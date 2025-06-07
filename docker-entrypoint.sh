#!/bin/bash

set -e

# Configure .env for SQLite if not already configured
if [ ! -f .env ]; then
    cp .env.example .env
fi

if ! grep -q "DB_CONNECTION=sqlite" .env; then
    sed -i 's/DB_CONNECTION=.*/DB_CONNECTION=sqlite/' .env
    sed -i 's/DB_DATABASE=.*/DB_DATABASE=\/var\/www\/database\/database.sqlite/' .env
fi

# Generate application key if not set
if ! grep -q "APP_KEY=base64" .env; then
    php artisan key:generate
fi

# Wait for database to be ready (for other DB types)
# while ! php artisan db:monitor >/dev/null 2>&1; do
#     echo "Waiting for database to be ready..."
#     sleep 1
# done

# Run migrations
php artisan migrate --force

exec "$@"