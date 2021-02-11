Faker::Config.locale = :ja

FactoryBot.define do
  factory :user do
    nickname { Faker::Name.initials(number: 5) }
    email { Faker::Internet.free_email }
    password { '1a' + Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    family_name { Faker::Name.last_name }
    first_name { Faker::Name.first_name }
    family_name_kana { 'サンプル' }
    first_name_kana { 'タロウ' }
    birthday { Faker::Date.in_date_period }
    introduction { Faker::Lorem.sentence }

    after(:build) do |user|
      user.avatar.attach(io: File.open('public/images/silhouette-3199472_1280.png'), filename: 'test_image.png')
    end
  end
end
