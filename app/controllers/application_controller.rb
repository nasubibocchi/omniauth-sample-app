class ApplicationController < ActionController::Base
  # CSRF保護を有効にする
  protect_from_forgery with: :exception

  # Deviseのパラメータ許可
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :avatar])
  end

  # 管理者権限チェック
  def ensure_admin
    redirect_to root_path, alert: '管理者権限が必要です。' unless current_user&.admin?
  end

  # Flash メッセージのタイプをTailwind CSSクラスにマッピング
  def flash_class(type)
    case type.to_s
    when 'notice'
      'bg-green-100 border-green-400 text-green-700'
    when 'alert'
      'bg-red-100 border-red-400 text-red-700'
    when 'warning'
      'bg-yellow-100 border-yellow-400 text-yellow-700'
    else
      'bg-blue-100 border-blue-400 text-blue-700'
    end
  end

  helper_method :flash_class

  private

  # ユーザーのサインイン後のリダイレクト先を設定
  def after_sign_in_path_for(resource)
    stored_location_for(resource) || root_path
  end

  # ユーザーのサインアウト後のリダイレクト先を設定
  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end

  # レコードが見つからない場合のエラーハンドリング
  rescue_from ActiveRecord::RecordNotFound do |exception|
    redirect_to root_path, alert: '指定されたページが見つかりません。'
  end
end
