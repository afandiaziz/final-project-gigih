FactoryBot.define do
  factory :menu_item do
    name { Faker::Food.dish }
    description { Faker::Food.description }
    price { Faker::Commerce.price(range: 2000..100000.0) }
  end
end
