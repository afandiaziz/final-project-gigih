# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
if Customer.count == 0
    for i in 1..10 do
        Customer.create(
            name: Faker::Name.name,
            email: Faker::Internet.unique.email,
            phone: Faker::PhoneNumber.unique.phone_number
        )
    end
end
if Category.count == 0
    for i in 1..5 do
        Category.create(
            name: Faker::Food.unique.ethnic_category
        )
    end
end
if MenuItem.count == 0
    for i in 1..5 do
        MenuItem.create(
            name: Faker::Food.unique.dish,
            description: "This is Description of Menu Item",
            price: Faker::Commerce.price(range: 2000..100000.0),
        )
    end
end
if ItemCategory.count == 0
    selected = []
    for i in 1..5 do
        totalCategories = Faker::Number.between(from: 1, to: 3)
        for j in 1..totalCategories do
            category_id = Faker::Number.between(from: 1, to: 5)
            if !selected.include?(category_id)
                selected.push(category_id)
                ItemCategory.create(
                    item_id: i,
                    category_id: category_id,
                )
            end
        end
    end
end
if Order.count == 0
    for i in 1..15 do
        order = Order.create(
            customer_id: Faker::Number.between(from: 1, to: 10)
        )
        if order.id
            totalOrderDetail = Faker::Number.between(from: 1, to: 4)
            menuItemSelected = []
            for j in 1..totalOrderDetail do
                menuitem_id = Faker::Number.between(from: 1, to: 5)
                if !menuItemSelected.include?(menuitem_id)
                    menuItemSelected.push(menuitem_id)
                    menuItem = MenuItem.find(menuitem_id)
                    OrderDetail.create(
                        order_id: order.id,
                        menu_item_id: menuitem_id,
                        price: menuItem.price,
                        quantity: Faker::Number.between(from: 1, to: 4)
                    )
                end
            end
        end 
    end
end
# for i in 1..5 do
#     Category.create(
#         name: Faker::Food.unique.ethnic_category
#     )
# end
# for i in 1..5 do
#     MenuItem.create(
#         name: Faker::Food.unique.dish,
#         description: "This is Description of Menu Item",
#         price: Faker::Commerce.price(range: 2000..100000.0),
#     )
# end
# for i in 1..10 do
#     ItemCategory.create(
#         item_id: Faker::Number.between(from: 5, to: 9),
#         category_id: Faker::Number.between(from: 13, to: 17),
#     )
# end
# for i in 1..15 do
#     order = Order.create(
#         customer_id: Faker::Number.between(from: 3, to: 13)
#     )
#     if order.id
#         totalOrderDetail = Faker::Number.between(from: 1, to: 4)
#         menuItemSelected = []
#         for j in 1..totalOrderDetail do
#             menuitem_id = Faker::Number.between(from: 3, to: 9)
#             if !menuItemSelected.include?(menuitem_id)
#                 menuItemSelected.push(menuitem_id)
    
#                 menuItem = MenuItem.find(menuitem_id)
#                 OrderDetail.create(
#                     order_id: order.id,
#                     menu_item_id: menuitem_id,
#                     price: menuItem.price,
#                     quantity: Faker::Number.between(from: 1, to: 4)
#                 )
#             end
#         end
#         print totalOrderDetail, " . "
#         puts order.id
#     end 
# end