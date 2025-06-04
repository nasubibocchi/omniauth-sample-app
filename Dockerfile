FROM ruby:3.4-alpine

# 必要なパッケージをインストール
RUN apk add --no-cache \
    build-base \
    postgresql-dev \
    nodejs \
    npm \
    git \
    tzdata \
    imagemagick \
    vips-dev \
    yaml-dev \
    gmp-dev \
    openssl-dev \
    libffi-dev \
    readline-dev \
    zlib-dev

# pnpmをグローバルインストール
RUN npm install -g pnpm

# アプリケーション用のディレクトリを作成
WORKDIR /app

# GemfileとGemfile.lockをコピー
COPY Gemfile Gemfile.lock ./

# Bundlerをインストールしてgemをインストール
RUN gem install bundler && \
    bundle install

# package.jsonとpnpm-lock.yamlをコピー
COPY package.json pnpm-lock.yaml ./

# pnpmパッケージをインストール
RUN pnpm install --frozen-lockfile

# アプリケーションコードをコピー
COPY . .

# ポート3000を公開
EXPOSE 3000

# サーバーを起動
CMD ["rails", "server", "-b", "0.0.0.0"]
