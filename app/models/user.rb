class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items
  has_many :purchases
  has_one_attached :avatar

  # allow users to update their accounts without passwords
  def update_without_current_password(params)
    self.attributes = params
    save
  end

  def validate_specific_columns(columns)
    errors = 0
    columns.valid?
    # binding.pry
    columns.errors.full_messages.each do |error|
      errors += 1 unless error.include?('Password')
    end
    errors
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
