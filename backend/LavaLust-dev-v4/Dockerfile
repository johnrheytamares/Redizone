# Official PHP + Apache base image
FROM php:8.2-apache

# Enable .htaccess (super important para sa LavaLust routing)
RUN a2enmod rewrite

# Install PDO MySQL driver (para makaconnect sa sql12freedatabase.com)
RUN docker-php-ext-install pdo_mysql

# Set document root to public folder (LavaLust expects this)
ENV APACHE_DOCUMENT_ROOT /var/www/html/public
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

# Working directory
WORKDIR /var/www/html

# Copy only the backend code
COPY backend/LavaLust-dev-v4 /var/www/html

# Install Composer + dependencies
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && composer install --no-dev --optimize-autoloader --no-interaction

# Apache runs in foreground (required by Render)
CMD ["apache2-foreground"]