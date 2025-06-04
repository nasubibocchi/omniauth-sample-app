class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # callback for google_oauth2 (ルートに合わせる)
  def google_oauth2
    callback_for(:google)
  end

  def failure
    flash[:alert] = 'Google認証に失敗しました。再度お試しください。'
    redirect_to new_user_session_path
  end

  private

  def callback_for(provider)
    @user = User.from_omniauth(request.env['omniauth.auth'])
  
    if @user.persisted?
      # 再認証の場合は特別なメッセージ
      if request.env['omniauth.params'] && request.env['omniauth.params']['reauth'] == 'true'
        flash[:notice] = '🔄 Google再認証が完了しました。'
      else
        flash[:notice] = 'Google認証に成功しました。'
      end
      sign_in_and_redirect @user, event: :authentication
    end
  end
end
