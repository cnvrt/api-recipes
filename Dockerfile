# Use the official PHP image from the Docker Hub
FROM php:8.2-apache

# Copy your PHP source files into the container
COPY . /var/www/html/

# Set the working directory
WORKDIR /var/www/html

# Set default PHP configuration
RUN cp /usr/local/etc/php/php.ini-development /usr/local/etc/php/php.ini
RUN echo 'variables_order = "EGPCS"' >> /usr/local/etc/php/php.ini

# Copy MongoDB extension and enable it
COPY ./config/mongodb-ssl.so /usr/local/lib/php/extensions/no-debug-non-zts-20220829/mongodb.so
RUN echo "extension=mongodb.so" >> /usr/local/etc/php/php.ini

# Copy Apache configuration
COPY ./config/apache2.conf /etc/apache2/apache2.conf

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Expose port 80
EXPOSE 80
