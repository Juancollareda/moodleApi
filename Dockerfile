FROM php:8.1-apache

# Instalar dependencias y extensiones requeridas por Moodle
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

# Crear el directorio de datos de Moodle (writable en Render)
RUN mkdir -p /var/moodledata \
    && chown -R www-data:www-data /var/moodledata \
    && chmod -R 775 /var/moodledata

# Descargar Moodle
RUN git clone -b MOODLE_402_STABLE https://github.com/moodle/moodle.git /var/www/html \
    && chown -R www-data:www-data /var/www/html

# Exponer puerto HTTP
EXPOSE 80

# Comando final default de Apache
CMD ["apache2-foreground"]
