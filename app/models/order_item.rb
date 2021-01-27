class OrderItem
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :city, :address, :building, :phone_number, :purchase_id
  
  with_options presence: true do
    validates :user_id, forign_key: true
    validates :item_id, forign_key: true
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)" }
    validates :prefecture_id, numericality: { other_than: 1 }
    validates :city
    validates :address
    validates :phone_number, numericality: { only_integer: true, message: "Input only number"}
    validates :purchase_id, forign_key: true
  end

  def save
    Purchase.create(user_id: current_user.id, item_id: item_id)
    Delivery.create(
      :postal_code,
      :prefecture_id,
      :city, 
      :address, 
      :building, 
      :phone_number,
      :purchase_id
    )
  end
end