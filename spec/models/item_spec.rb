require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end
  describe '商品出品機能' do
    context '商品を出品できるとき' do
      it '全ての項目が存在すれば出品できる' do
        
      end
    end

    context '商品を出品できないとき' do
      it 'imageが空では出品できない' do
        
      end
      it 'nameが空では出品できない' do
        
      end
      it 'explanationが空では出品できない' do
        
      end
      it 'category_idが空では出品できない' do
        
      end
      it 'item_status_idが空では出品できない' do
        
      end
      it 'delivery_feeが空では出品できない' do
        
      end
      it 'shipping_area_idが空では出品できない' do
        
      end
      it 'days_to_ship_idが空では出品できない' do
        
      end
      it 'priceが空では出品できない' do
        
      end
      it 'priceが¥300〜¥9,999,999の間でなければ出品できない' do
        
      end
      it 'priceが全角では出品できない' do
        
      end
    end
  end
end
