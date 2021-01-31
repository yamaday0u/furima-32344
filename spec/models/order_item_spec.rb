require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  before do
    @purchase = FactoryBot.build(:order_item)
  end
  
  describe "商品購入機能" do
    context "商品購入ができるとき" do
      it "必要な情報を適切に入力すると、商品の購入ができること" do
        expect(@purchase).to be_valid
      end
      it "建物名が空でも購入できること" do
        @purchase.building = ""
        expect(@purchase).to be_valid
      end
    end

    context "商品購入ができないとき" do
      it "郵便番号が空では購入できないこと" do
        @purchase.postal_code = ""
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("Postal code can't be blank")
      end
      it "郵便番号にハイフンがないと購入できないこと" do
        @purchase.postal_code = "1001111"
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
      end
      it "都道府県が空では購入できないこと" do
        @purchase.prefecture_id = ""
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("Prefecture can't be blank")
      end
      it "市区町村が空では購入できないこと" do
        @purchase.city = ""
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("City can't be blank")
      end
      it "番地が空では購入できないこと" do
        @purchase.address = ""
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("Address can't be blank")
      end
      it "電話番号が空では購入できないこと" do
        @purchase.phone_number = ""
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("Phone number can't be blank")
      end
      it "電話番号はハイフンが不要であること" do
        @purchase.phone_number = "090-123-567"
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("Phone number Input only number")
      end
      it "電話番号は11桁以内でないと購入できないこと" do
        @purchase.phone_number = "090123456789"
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("Phone number is invalid. Input number within 11 digits")
      end
      it "トークンが空では登録できないこと" do
        @purchase.token = ""
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end

 
# - 商品購入ページでは、一覧や詳細ページで選択した商品の情報が出力されること
# - ログアウト状態のユーザーは、URLを直接入力して商品購入ページに遷移しようとすると、商品の販売状況に関わらずログインページに遷移すること
# - ログイン状態の出品者が、URLを直接入力して自身の出品した商品購入ページに遷移しようとすると、トップページに遷移すること
# - ログイン状態のユーザーが、URLを直接入力して売却済み商品の商品購入ページへ遷移しようとすると、トップページに遷移すること
# - クレジットカード決済ができること
# - クレジットカードの情報は購入の都度入力させること
# - クレジットカード情報は必須であり、正しいクレジットカードの情報で無いときは決済できないこと

# - 購入が完了したら、トップページまたは購入完了ページに遷移すること
# - エラーハンドリングができていること（適切では無い値が入力された場合、情報は保存されず、エラーメッセージを出力させること）
# - 入力に問題がある状態で購入ボタンが押されたら、購入ページに戻りエラーメッセージが表示されること
