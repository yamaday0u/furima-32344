FactoryBot.define do
  factory :item do
    image {Faker::Avatar.image}
    name {Faker::Lorem.word}
    explanation {Faker::Lorem.sentence}
    category_id {Faker::Number.within(range: 2..11)}
    item_status_id {Faker::Number.within(range: 2..7)}
    delivery_fee_id {Faker::Number.within(range: 2..3)}
    shipping_area_id {Faker::Number.within(range: 2..48)}
    days_to_ship_id {Faker::Number.within(range: 2..4)}
    price {Faker::Number.within(range: 300..9999999)}
  end
end
