FROM php:8.1-apache

# Instalar dependencias
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

# Configurar DocumentRoot
WORKDIR /var/www/html

# Descargar Moodle (solo el código)
RUN git clone -b MOODLE_402_STABLE https://github.com/moodle/moodle.git /var/www/html \
    && chown -R www-data:www-data /var/www/html

# Crear carpetas donde Render montará sus volúmenes
RUN mkdir -p /var/www/moodledata \
    && mkdir -p /var/www/config \
    && chown -R www-data:www-data /var/www/moodledata /var/www/config

# Moodle busca config.php en /var/www/html; lo linkeamos hacia volumen persistente
RUN ln -s /var/www/config/config.php /var/www/html/config.php || true

EXPOSE 80

CMD ["apache2-foreground"]

