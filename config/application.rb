require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module OmniauthSampleApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.2

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.

    # タイムゾーンを日本時間に設定
    config.time_zone = 'Tokyo'

    # データベースのタイムゾーンも日本時間に設定
    config.active_record.default_timezone = :local

    # 日本語をデフォルト言語に設定
    config.i18n.default_locale = :ja

    # 使用可能な言語を設定
    config.i18n.available_locales = [:ja, :en]

    # アプリケーション全体の設定
    config.generators do |g|
      g.test_framework :rspec,
        fixtures: true,
        view_specs: false,
        helper_specs: false,
        routing_specs: false,
        controller_specs: false,
        request_specs: false
      g.fixture_replacement :factory_bot, dir: "spec/factories"
    end

    # Active Storageの設定
    config.active_storage.variant_processor = :mini_magick

    # Railsの自動読み込みパスの設定
    config.autoload_paths += %W(#{config.root}/app/services)

    config.middleware.use OmniAuth::Builder do
      provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET']
    end
  end
end
