#novo
FROM php:7.2-apache

# Adds apache configurations
ADD ./docker/apache/nasa.conf   /etc/apache2/sites-available
ADD ./docker/apache/admin.nasa.conf   /etc/apache2/sites-available

#driver pdo_mysql
RUN docker-php-ext-install mbstring pdo pdo_mysql

# Environment configurations
RUN a2ensite nasa.conf
RUN a2ensite admin.nasa.conf
RUN a2enmod rewrite

# Set apps home directory.
ENV APP_DIR /var/www/html

# Adds the application code to the image
ADD ./web ${APP_DIR}

WORKDIR ${APP_DIR}

# Cleanup
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 80
