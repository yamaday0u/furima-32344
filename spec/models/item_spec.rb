require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end
  describe '商品出品機能' do
    context '商品を出品できるとき' do
      it '全ての項目が存在すれば出品できる' do
        expect(@item).to be_valid
      end
    end

    context '商品を出品できないとき' do
      it 'imageが空では出品できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("画像 が空欄です")
      end
      it 'nameが空では出品できない' do
        @item.name = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("商品名 が空欄です")
      end
      it 'explanationが空では出品できない' do
        @item.explanation = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の説明 が空欄です")
      end
      it 'category_idが1では出品できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('カテゴリー が選択されていません')
      end
      it 'category_idが未選択では出品できない' do
        @item.category_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("カテゴリー が選択されていません")
      end
      it 'item_status_idが1では出品できない' do
        @item.item_status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('商品の状態 が選択されていません')
      end
      it 'item_status_idが未選択では出品できない' do
        @item.item_status_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の状態 が選択されていません")
      end
      it 'delivery_feeが1では出品できない' do
        @item.delivery_fee_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('配送料の負担 が選択されていません')
      end
      it 'delivery_fee_idが未選択では出品できない' do
        @item.delivery_fee_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("配送料の負担 が選択されていません")
      end
      it 'shipping_area_idが1では出品できない' do
        @item.shipping_area_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('発送元の地域 が選択されていません')
      end
      it 'shipping_area_idが未選択では出品できない' do
        @item.shipping_area_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("発送元の地域 が選択されていません")
      end
      it 'days_to_ship_idが1では出品できない' do
        @item.days_to_ship_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('発送までの日数 が選択されていません')
      end
      it 'days_to_ship_idが未選択では出品できない' do
        @item.days_to_ship_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("発送までの日数 が選択されていません")
      end
      it 'priceが空では出品できない' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格 が空欄です')
      end
      it 'priceが¥300〜¥9,999,999の間でなければ出品できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格 は300円から9,999,999円の間で入力してください')
      end
      it 'priceが¥300〜¥9,999,999の間でなければ出品できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格 は300円から9,999,999円の間で入力してください')
      end
      it 'priceが全角では出品できない' do
        @item.price = '３００'
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格 は300円から9,999,999円の間で入力してください')
      end
    end
  end
end
