#############################################
### OSのセットアップ
#############################################
FROM rockylinux/rockylinux:9.2

# 必要なパッケージのインストール
RUN dnf -y update && \
    dnf -y install git && \
    dnf clean all

#############################################
### 開発言語のセットアップ
#############################################
# PHPのインストール
RUN dnf -y install httpd php php-cli php-fpm php-json php-common php-mbstring php-zip php-gd php-xml php-curl

# Composer のインストール
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY ./.devcontainer/files/etc/httpd/conf.d/web.conf /etc/httpd/conf.d/web.conf
COPY ./.devcontainer/files/etc/php-fpm.d/www.conf /etc/php-fpm.d/www.conf

# ドキュメントルートの作成
RUN mkdir -p /app/src/php
# php-fpm のためのディレクトリを作成
RUN mkdir -p /run/php-fpm/


#############################################
### 作業環境のセットアップ
#############################################
WORKDIR /app

COPY ./.devcontainer/.bashrc /root/.bashrc

CMD (/usr/sbin/php-fpm -D && /usr/sbin/httpd -D FOREGROUND)