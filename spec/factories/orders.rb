FactoryBot.define do
  factory :order do
    customer_id { Faker::Number.between(from: 1, to: 10) }
  end
end
