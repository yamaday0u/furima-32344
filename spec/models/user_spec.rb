require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe '新規登録/ユーザー情報' do
    context '新規登録できるとき' do
      it '全ての項目が存在すれば登録できる' do
        expect(@user).to be_valid
      end
      it 'passwordが6文字以上の半角英数字であれば登録できる' do
        @user.password = '123abc'
        @user.password_confirmation = @user.password
        expect(@user).to be_valid
      end
    end
    context '新規登録できないとき' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it '重複したemailが存在する場合登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'emailに@が含まれていないと登録できない' do
        @user.email.slice!('@')
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = '123ab'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'passwordが半角英数字混合での入力されていないと登録できない' do
        @user.password = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には半角の英字と数字の両方を含めて設定してください')
      end
      it 'passwordが存在してもpassword_confirmationが空では登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'passwordが数字のみだと登録できない' do
        @user.password = '123456'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には半角の英字と数字の両方を含めて設定してください')
      end
      it ' passwordに全角が含まれていると登録できない' do
        @user.password = '12３abc'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には半角の英字と数字の両方を含めて設定してください')
      end
    end

    describe '新規登録/本人情報確認' do
      it 'first_nameが空欄では登録できないこと' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it 'family_nameが空欄では登録できないこと' do
        @user.family_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name can't be blank")
      end
      it 'first_nameが半角では登録できないこと' do
        @user.first_name = 'ﾀﾛｳ'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name には全角で入力して下さい')
      end
      it 'family_nameが半角では登録できないこと' do
        @user.family_name = 'ｻﾝﾌﾟﾙ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Family name には全角で入力して下さい')
      end
      it 'first_name_kanaが空欄では登録できないこと' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end
      it 'family_name_kanaが空欄では登録できないこと' do
        @user.family_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name kana can't be blank")
      end
      it 'first_name_kanaが半角カタカナでは登録できないこと' do
        @user.first_name_kana = 'ﾀﾛｳ'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana には全角カタカナのみで入力して下さい')
      end
      it 'family_name_kanaが半角カタカナでは登録できないこと' do
        @user.family_name_kana = 'ｻﾝﾌﾟﾙ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Family name kana には全角カタカナのみで入力して下さい')
      end
      it 'first_name_kanaがカタカナでの入力されていないと登録できないこと' do
        @user.first_name_kana = 'たろう'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana には全角カタカナのみで入力して下さい')
      end
      it 'family_name_kanaがカタカナでの入力されていないと登録できないこと' do
        @user.family_name_kana = 'さんぷる'
        @user.valid?
        expect(@user.errors.full_messages).to include('Family name kana には全角カタカナのみで入力して下さい')
      end
      it 'birthdayが空では登録できないこと' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end
