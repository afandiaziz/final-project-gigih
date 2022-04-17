FactoryBot.define do
  factory :menu_item do
    name { Faker::Food.unique.dish }
    description { "This is Description of Menu Item" }
    price { Faker::Commerce.price(range: 2000..100000.0) }
  end
end
