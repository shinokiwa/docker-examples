# Exment コンテナ

## 概要

シンプルな MariaDB 利用の Exment を構成するコンテナ群です。<br>
意図的に公式のDocker構成を利用せず、仕様調査などに使うような単純なものにしています。<br>
本番運用する場合は公式のDocker構成を使うことを推奨します。

## 使い方

```
docker compose up -d
```

## 構成

- RockyLinux 9.1
- nginx
- PHP 8.1 & PHP-fpm
- MariaDB

## 設定など

初期状態では、以下のデータベースが作成されます。

- ホスト名: mariadb
- ポート: 3306
- データベース: laravel
- ユーザー名: root
- パスワード: secret


## 備考

- 初期状態では http://localhost:8080/admin/ でアクセスします。
- MariaDB は外部からアクセスできません。

## 関連

- [Exment 公式](https://exment.net/)

## タスクリスト

- TODO: 設定のところのバージョン表記

