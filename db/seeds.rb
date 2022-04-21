# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# for i in 1..2 do
#     Customer.create(
#         name: Faker::Name.name,
#         email: Faker::Internet.unique.email,
#         phone: Faker::PhoneNumber.unique.phone_number
#     )
# end
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