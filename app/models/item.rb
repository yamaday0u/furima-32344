class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
# 以下に他のカラムのアソシエーションを追加する
  belongs_to_active_hash :item_status
  belongs_to_active_hash :delivery_fee
  belongs_to_active_hash :shipping_area

  has_one_attached :image
end
