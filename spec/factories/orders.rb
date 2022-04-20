FactoryBot.define do
  factory :order do
    customer_id { 1 }
    status { "MyString" }
  end
end
