#!/bin/sh

# Wait for dependencies to load
sleep 10;

# Install composer dependencies
composer install -n -o

# Run PHP
php-fpm --nodaemonize
