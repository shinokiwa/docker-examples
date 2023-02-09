FROM rockylinux:9.1

WORKDIR /app

RUN dnf update -y && dnf upgrade --refresh -y && \
    dnf install -y \
    https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm \
    https://rpms.remirepo.net/enterprise/remi-release-9.rpm \
    && \
    dnf install dnf-utils http://rpms.remirepo.net/enterprise/remi-release-9.rpm -y && \
    dnf module enable php:remi-8.1 -y

RUN dnf install -y \
    nginx \
    mysql \
    php php-fpm \
    git wget gnupg vim unzip \
    libxml2-devel libpng-devel libzip oniguruma \
    php-mbstring php-dom php-gd php-zip php-mysql

# install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# PHPの実行ユーザーとグループを追加
RUN groupadd php && \
    useradd -m -s /bin/bash -g php php
RUN mkdir -p /run/php-fpm/ && chown php:php /run/php-fpm/

# install exment
RUN mkdir /app/exment
WORKDIR /app/exment
RUN COMPOSER_MEMORY_LIMIT=-1 composer create-project laravel/laravel=9.* .
RUN composer config --no-plugins allow-plugins.kylekatarnls/update-helper true
RUN composer require psr/simple-cache=^2.0
RUN COMPOSER_MEMORY_LIMIT=-1 composer require exceedone/exment=~5.0

RUN php artisan vendor:publish --provider="Exceedone\\Exment\\ExmentServiceProvider"
RUN chown -R php:php /app/exment \
  && chmod 755 -R /app/exment/storage \
  && chmod 755 -R /app/exment/bootstrap/cache


COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf
COPY ./php/www.conf /etc/php-fpm.d/www.conf
COPY ./php/php-fpm.conf /etc/php-fpm.conf
COPY ./php/php.ini /etc/php.ini

COPY ./entrypoint.sh /
ENTRYPOINT [ "/entrypoint.sh" ]
