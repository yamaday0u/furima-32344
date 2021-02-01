FactoryBot.define do
  factory :order_item do
    postal_code { '100-1111' }
    prefecture_id { Faker::Number.within(range: 2..48) }
    city { Faker::Address.city }
    address { Faker::Address.secondary_address }
    building { Faker::Address.building_number }
    phone_number { '09012345678' }
    token { 'tok_abcdefghijk00000000000000000' }
  end
end
