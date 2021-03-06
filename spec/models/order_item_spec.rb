require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @purchase = FactoryBot.build(:order_item, user_id: @user.id, item_id: @item.id)
  end

  describe '商品購入機能' do
    context '商品購入ができるとき' do
      it '必要な情報を適切に入力すると、商品の購入ができること' do
        expect(@purchase).to be_valid
      end
      it '建物名が空でも購入できること' do
        @purchase.building = ''
        expect(@purchase).to be_valid
      end
    end

    context '商品購入ができないとき' do
      it '郵便番号が空では購入できないこと' do
        @purchase.postal_code = ''
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include('郵便番号 が空欄です')
      end
      it '郵便番号にハイフンがないと購入できないこと' do
        @purchase.postal_code = '1001111'
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include('郵便番号 郵便番号はハイフン(-)を入れてください')
      end
      it '都道府県が空では購入できないこと' do
        @purchase.prefecture_id = ''
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include('都道府県 が選択されていません')
      end
      it '都道府県のid:1を選択した場合、購入できないこと' do
        @purchase.prefecture_id = 1
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include('都道府県 が選択されていません')
      end
      it '市区町村が空では購入できないこと' do
        @purchase.city = ''
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include('市区町村 が空欄です')
      end
      it '番地が空では購入できないこと' do
        @purchase.address = ''
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include('番地 が空欄です')
      end
      it '電話番号が空では購入できないこと' do
        @purchase.phone_number = ''
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include('電話番号 が空欄です')
      end
      it '電話番号はハイフンが不要であること' do
        @purchase.phone_number = '090-123-567'
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include('電話番号 は半角数字(10〜11ケタ)で入力してください')
      end
      it '電話番号は11桁以内でないと購入できないこと' do
        @purchase.phone_number = '090123456789'
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include('電話番号 は半角数字(10〜11ケタ)で入力してください')
      end
      it '電話番号は全角数字だと登録できない事購入できないこと' do
        @purchase.phone_number = '０９０１２３４５６７８'
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include('電話番号 は半角数字(10〜11ケタ)で入力してください')
      end
      it '電話番号は9桁以下だと購入できないこと' do
        @purchase.phone_number = '090123456'
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include('電話番号 は半角数字(10〜11ケタ)で入力してください')
      end
      it 'user_idが空だと登録できない' do
        @purchase.user_id = ''
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include('ユーザー が空欄です')
      end
      it 'item_idが空だと登録できない' do
        @purchase.item_id = ''
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include('商品 が空欄です')
      end
      it 'トークンが空では登録できないこと' do
        @purchase.token = ''
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include('クレジットカード の情報が正しくありません')
      end
    end
  end
end
