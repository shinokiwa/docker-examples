#############################################
### OSのセットアップ
#############################################
FROM rockylinux:9.2

# 必要なパッケージのインストール
RUN amazon-linux-extras install -y

RUN yum update -y \
  && yum install -y \
  wget curl unzip sudo tar git

#############################################
### 開発言語のセットアップ
#############################################
# 例としてPython
RUN yum update -y \
  && yum install -y \
  python

#############################################
### 作業環境のセットアップ
#############################################
WORKDIR /app

# 作業環境の設定
COPY ./.devcontainer/.bashrc /root/.bashrc

CMD ["sh"]
