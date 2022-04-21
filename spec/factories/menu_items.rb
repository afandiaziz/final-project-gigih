FactoryBot.define do
  factory :menu_item do
    name { Faker::Name.unique.name }
    # harusnya faker dibawah ini, tapi faker food.dish nya sedikit banget dan harus unique 
      # name { Faker::Food.unique.dish }
    description { "This is Description of Menu Item" }
    price { Faker::Commerce.price(range: 2000..100000.0) }
  end
end
