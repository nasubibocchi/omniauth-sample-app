source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.4.4"

# Rails本体
gem "rails", "~> 7.2.0"

# データベース
gem "pg", "~> 1.1"

# フロントエンド関連
gem "sprockets-rails", ">= 3.4.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "image_processing", "~> 1.2"

# UI・スタイリング
gem "tailwindcss-rails"

# 認証
gem "devise"
gem "omniauth-google-oauth2"
gem "omniauth-rails_csrf_protection"

# OAuth Provider（将来のDoorkeeper用）
gem "doorkeeper"

# Redisサポート
gem "redis", "~> 4.0"

# バックグラウンドジョブ
gem "sidekiq"

# Webサーバー
gem "puma", "~> 6.0"

# ブートタイム短縮
gem "bootsnap", ">= 1.4.4", require: false

# タイムゾーン情報
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

group :development, :test do
  # デバッグ
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem "pry-rails"
  gem "pry-byebug"
  
  # テストフレームワーク
  gem "rspec-rails"
  gem "factory_bot_rails"
  gem "faker"
end

group :development do
  # リアルタイムリロード
  gem "web-console"
  
  # エラー画面改善
  gem "better_errors"
  gem "binding_of_caller"
  
  # コード品質
  gem "rubocop-rails", require: false
  gem "brakeman", require: false
  
  # パフォーマンス監視
  gem "listen", "~> 3.3"
  gem "spring"
end

group :test do
  # テストヘルパー
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end
