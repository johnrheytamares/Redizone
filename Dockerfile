# Render auto-generates this, but just in case:
FROM php:8.2-apache

# Enable mod_rewrite (for LavaLust .htaccess)
RUN a2enmod rewrite

# Install any needed extensions (most are already in php:apache)
RUN docker-php-ext-install pdo_mysql

# Set working directory
WORKDIR /var/www/html

# Copy only the backend code
COPY backend/LavaLust-dev-v4 /var/www/html

# Install Composer dependencies
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && composer install --no-dev --optimize-autoloader

# Expose port (Render ignores this, but good practice)
EXPOSE 8080

# Apache runs in foreground by default
CMD ["apache2-foreground"]