FROM php:8.0-fpm

RUN apt-get update

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN apt-get install -y  \
    libmagickwand-dev \
    libpng-dev \
    libmcrypt-dev \
    libzip-dev \
    libpq-dev \
    --no-install-recommends \
    && pecl install imagick \
    && docker-php-ext-enable imagick \
    # && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install pdo \
    && docker-php-ext-install zip \
    && docker-php-ext-install gd \
    && docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql \
    && docker-php-ext-install pdo pdo_pgsql pgsql

##CMD composer install --no-scripts --no-autoloader --prefer-dist --no-interaction && php artisan migrate:refresh --seed
