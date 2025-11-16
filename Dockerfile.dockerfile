FROM php:8.1-apache

# Extensiones requeridas
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    mariadb-client \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libxml2-dev \
    libzip-dev \
    libicu-dev \
    && docker-php-ext-install mysqli gd xml zip intl

# Descargar Moodle
RUN git clone -b MOODLE_402_STABLE https://github.com/moodle/moodle.git /var/www/html

# Configuración de Apache
RUN chown -R www-data:www-data /var/www/html

EXPOSE 80
