# Traefik 実行構成

## 概要

Traefik の機能を使って、同一の Docker ネットワークに属するコンテナの開放ポートを自動的に判別し、リバースプロキシするコンテナです。<br>
.evnで指定したドメイン（デフォルトは localhost）に対して、 <プロジェクト名>.localhost で対象プロジェクトにルーティングします。<br>
SSL周りの設定はしていません。

## 使い方

基本は

```
docker compose up -d
```

で動きます。

Windows ホストで実行する場合は、以下の環境変数を設定する必要があります。<br>
実行時のターミナルに設定すればよく、常時設定する必要はありません。

```
COMPOSE_CONVERT_WINDOWS_PATHS=1
```

## 仕様

- ドメインを指定する場合、 env.example をコピーし .env にリネーム後、 DOMAIN_NAME= に指定するドメインを設定してください。
- デフォルト動作の場合、composeに以下のラベルを設定したコンテナの **プロジェクト名** をサブドメインとしてリバースプロキシを始めます。

## labelsの書き方

リバースプロキシの対象となるコンテナは、同一ネットワークに所属し、規定のlabelsを設定すれば自動的に認識されます。<br>
実際にはルーティングを行うだけの話ですので、**サブドメインのDNS設定は別途行ってください**。

## docker-compose.ymlの書き方

コンテナの compose ファイルにラベルを記載することで、リバースプロキシを制御することができます。<br>

例:

```
    labels:
      - "traefik.enable=true"
      - "traefik.http.services.mattermost.loadbalancer.server.port=8080"
      - "traefik.http.routers.mattermost.rule=Host(`www.${DOMAIN_NAME:-localhost}`)"
      - "traefik.http.routers.mattermost.entrypoints=https"
```
- 実際には、上記 mattermost の部分はリバースプロキシ全体で一意になるような名前をつけてください。Web アクセスが1コンテナ分しかないなら、プロジェクト名（ディレクトリ名）を流用するのが無難です。
- すべてデフォルト動作で良いのであれば、最初の `traefik.enable=true` のみ記載されていれば問題ありません。
- `traefik.enable=true`
  - **この設定は必須です。** これによってリバースプロキシがそのコンテナに対して動作するようになります。
- `traefik.http.services.mattermost.loadbalancer.server.port=8080`
  - Web 接続を行うポートを指定します。ポート 80 や 443 を使うのであれば省略して問題ありません。
- ``traefik.http.routers.mattermost.rule=Host(`mattermost.${DOMAIN_NAME:-localhost}`)``
  - この設定を省略した場合、 プロジェクト名 .kyushu-softas.info のドメインが自動的に設定されます。プロジェクト名は通常 compose ファイルが存在するディレクトリ名です。
  - このドメインでは都合が悪い場合、このHost内を編集してください。
- `traefik.http.routers.mattermost.entrypoints=https`
  - アクセスをhttpsに限定します。これを記載しない場合http/https両方可能になります。

## 備考

- TraefikのダッシュボードURLは https://traefik. DOMAIN_NAME /dashboard/ になります。
