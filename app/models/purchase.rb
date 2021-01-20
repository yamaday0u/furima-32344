class Purchase < ApplicationRecord
  belongs_to_active_hash :user
  belongs_to_active_hash :item
end
