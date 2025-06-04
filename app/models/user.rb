class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  has_one_attached :avatar

  # バリデーション
  validates :name, presence: true, length: { maximum: 50 }
  validates :provider, presence: true, if: :oauth_user?
  validates :uid, presence: true, if: :oauth_user?
  validates :uid, uniqueness: { scope: :provider }, if: :oauth_user?

  class << self
    # Omniauthによるユーザーの検索または作成
    def from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.email = auth.info.email
        user.password = Devise.friendly_token[0, 20]
        user.name = auth.info.name || auth.info.email.split('@').first
        user.provider = auth.provider
        user.uid = auth.uid
        
        # アバター画像の処理（エラーハンドリング付き）
        begin
          if auth.info.image.present?
            user.avatar.attach(io: URI.open(auth.info.image), filename: "#{user.name}_avatar.jpg")
          end
        rescue => e
          Rails.logger.warn "Failed to attach avatar: #{e.message}"
        end
      end
    end

    # 管理者権限のチェック
    def admin?(user)
      user&.admin?
    end
  end

  # OAuth関連メソッド
  def oauth_user?
    provider.present? && uid.present?
  end

  def google_user?
    provider == 'google_oauth2'
  end

  # パスワードが必要かどうかの判定（OAuthユーザーは不要）
  def password_required?
    super && !oauth_user?
  end

  # メール変更時の確認をスキップ（OAuthユーザーの場合）
  def email_required?
    super && !oauth_user?
  end

  # 管理者フラグ
  def admin?
    admin || false
  end
end
