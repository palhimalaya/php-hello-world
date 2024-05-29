FROM php:7.4-cli

# Set the working directory in the container
WORKDIR /var/www/html

# Copy the current directory contents into the container at /var/www/html
COPY . /var/www/html

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install the dependencies
RUN composer install

# Run the PHP script when the container launches
CMD [ "php", "-S", "0.0.0.0:8081", "-t", "/var/www/html" ]
