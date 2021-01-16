class Item < ApplicationRecord
  belogs_to :user

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
# 以下に他のカラムのアソシエーションを追加する
  belongs_to_active_hash :item_status
  belongs_to_active_hash :delivery_fee
  belongs_to_active_hash :shipping_area
  belongs_to_active_hash :days_to_ship

  has_one_attached :image

  with_options presence: true do
    validates :name
    validates :explantion
    validates :image
    with_options numericality: {ohter_than: 1} do
      validates :category
      validates :item_status
      validates :delivery_fee
      validates :shipping_area
      validates :days_to_ship
    end
    validates :price、format: {
      with: /\A\d+\z/, message: "is invalid. Input half-width characters.",
      with: /[\A3.{2,}]-[9{,7}]/, message: "is "
    }
  end
  
end
