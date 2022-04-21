FactoryBot.define do
  factory :order_detail do
    order_id { 1 }
    menu_item_id { Faker::Number.between(from: 1, to: 2) }
    price { Faker::Commerce.price(range: 2000..100000.0) }
    quantity { Faker::Number.between(from: 1, to: 3) }
  end
end
