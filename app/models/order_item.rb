class OrderItem
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :city, :address, :building, :phone_number, :purchase_id, :token
  
  with_options presence: true do
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)" }
    validates :prefecture_id, numericality: { other_than: 0 }
    validates :city
    validates :address
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: "is invalid. Input number within 11 digits"},
                              numericality: { only_integer: true, message: "Input only number"}
    validates :token
  end

  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    delivery = Delivery.create(
      postal_code: postal_code,
      prefecture_id: prefecture_id,
      city: city, 
      address: address, 
      building: building, 
      phone_number: phone_number,
      purchase_id: purchase.id
    )
  end
end