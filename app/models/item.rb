class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
# 以下に他のカラムのアソシエーションを追加する

  has_one_attached :image
end
