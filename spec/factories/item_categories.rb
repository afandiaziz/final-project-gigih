FactoryBot.define do
  factory :item_category do
    item_id { Faker::Number.between(from: 1, to: 20) }
    category_id { Faker::Number.between(from: 1, to: 20) }
  end
end
