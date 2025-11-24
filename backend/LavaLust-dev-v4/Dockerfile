FROM php:8.2-apache

# Enable rewrite for .htaccess
RUN a2enmod rewrite

# Install MySQL driver
RUN docker-php-ext-install pdo_mysql

# Change Apache document root to public folder
ENV APACHE_DOCUMENT_ROOT /var/www/html/LavaLust-dev-v4/public
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

# Working directory
WORKDIR /var/www/html

# Copy the entire repo, then use only the LavaLust folder
COPY . /var/www/html

# Install Composer + dependencies
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && composer install --no-dev --optimize-autoloader --no-interaction --working-dir=LavaLust-dev-v4

# Start Apache
CMD ["apache2-foreground"]