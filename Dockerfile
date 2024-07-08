FROM php:8.3.8-fpm

WORKDIR /var/www/laradoc

RUN apt-get update && apt-get install -y \
build-essential \
mariadb-client \
libpng-dev \
libjpeg-dev \
libfreetype6-dev \
libonig-dev \
libzip-dev \
libjpeg62-turbo-dev \
zip \
unzip \
git \
curl \
&& docker-php-ext-configure gd --with-freetype --with-jpeg \
&& docker-php-ext-install pdo pdo_mysql gd mbstring zip opcache
    


COPY --from=composer:latest /usr/bin/composer /usr/bin/composer


RUN  groupadd -g 1000 www
RUN useradd -u 1000 -ms /bin/bash -g www www

COPY . /var/www/laradoc

COPY --chown=www-data:www-data . /var/www/laradoc/

USER www

EXPOSE 9000

CMD ["php-fpm"]


