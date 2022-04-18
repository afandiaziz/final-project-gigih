FactoryBot.define do
    factory :item_category do
        category_id { Faker::Number.between(from: 1, to: 5) }
        item_id { Faker::Number.between(from: 1, to: 2) }
        # category_id { 1 }
        # item_id { 1 }
        # item_id { 
        #     create(:menu_item)
        #     MenuItem.first.id 
        # }
        # category_id { create(:item_category) }
    end
end 