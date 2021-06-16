class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook, :google_oauth2]

  has_many :items, dependent: :destroy
  has_many :purchases, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :sns_credentials
  has_one_attached :avatar

  # allow users to update their accounts without passwords
  def update_without_current_password(params)
    self.attributes = params
    save
  end

  def validate_specific_columns(columns)
    errors = 0
    columns.valid?
    columns.errors.full_messages.each do |error|
      errors += 1 unless error.include?('Password')
    end
    errors
  end

  def self.from_omniauth(auth)
    sns = SnsCredential.where(provider: auth.provider, uid: auth.uid).first_or_create
    # sns認証したことがあればアソシエーションで取得
    # 無ければemailでユーザー検索して取得orビルド(保存はしない)
    user = User.where(email: auth.info.email).first_or_initialize(
      nickname: auth.info.name,
      email: auth.info.email
    )
    # userが登録済みであるか判断
    if user.persisted?
      sns.user = user
      sns.save
    end
    { user: user, sns: sns }
  end

  with_options presence: true do
    validates :nickname
    validates :first_name, format: {
      with: /\A[^ -~｡-ﾟ]+\z/,
      message: 'には全角で入力して下さい'
    }
    validates :family_name, format: {
      with: /\A[^ -~｡-ﾟ]+\z/,
      message: 'には全角で入力して下さい'
    }
    validates :first_name_kana, format: {
      with: /\A[\p{katakana}　ー－&&[^ -~｡-ﾟ]]+\z/,
      message: 'には全角カタカナのみで入力して下さい'
    }
    validates :family_name_kana, format: {
      with: /\A[\p{katakana}　ー－&&[^ -~｡-ﾟ]]+\z/,
      message: 'には全角カタカナのみで入力して下さい'
    }
    validates :birthday

    PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
    validates_format_of :password, with: PASSWORD_REGEX, message: 'には半角の英字と数字の両方を含めて設定してください', on: :create # validate only users/registrations#create
  end
end
