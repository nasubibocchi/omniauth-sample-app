Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  # 他のアカウント種別がある場合の例
  # devise_for :admins, controllers: {
  #   omniauth_callbacks: 'admins/omniauth_callbacks'
  # }

  devise_scope :user do
    delete 'users/sign_out', to: 'devise/sessions#destroy'
  end

  get 'google_auth', to: 'home#google_auth', as: :google_auth
  get 'google_reauth', to: 'home#google_reauth', as: :google_reauth

  root 'home#index'

  # ヘルスチェック用エンドポイント
  get "up" => "rails/health#show", as: :rails_health_check
end
