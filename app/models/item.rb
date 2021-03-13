class Item < ApplicationRecord
  has_one :purchase
  has_many :comment
  belongs_to :user

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
    validates :explanation
    validates :image
    with_options numericality: { other_than: 1 } do
      validates :category_id
      validates :item_status_id
      validates :delivery_fee_id
      validates :shipping_area_id
      validates :days_to_ship_id
    end
    validates :price, format: { with: /\A\d+\z/, message: 'は半角数字で入力してください' },
                      numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, message: 'は300円から9,999,999円の間で入力してください' }
  end
end
