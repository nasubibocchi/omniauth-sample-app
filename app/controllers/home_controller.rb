class HomeController < ApplicationController
  def index
    if user_signed_in?
      @message = "✅ Google OAuth認証成功！"
      @user_info = {
        name: current_user.name,
        email: current_user.email,
        provider: current_user.provider,
        uid: current_user.uid,
        created_at: current_user.created_at
      }
    else
      @message = "❌ ログインしていません"
      @user_info = nil
    end
  end

  # 通常のGoogle認証用のアクション（named routeを使用）
  def google_auth
    redirect_to user_google_oauth2_omniauth_authorize_path, allow_other_host: true
  end

  # Google再認証用のアクション（named routeを使用）
  def google_reauth
    # named routeを使用して再認証
    redirect_to user_google_oauth2_omniauth_authorize_path(
      prompt: 'consent',  # 強制再認証
      reauth: 'true'
    ), allow_other_host: true
  end
end
