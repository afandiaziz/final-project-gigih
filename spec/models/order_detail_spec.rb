require 'rails_helper'

RSpec.describe OrderDetail, type: :model do
    describe '-- CREATE order detail' do
        it 'is invalid create without a order id' do
            order_detail = OrderDetail.create(
                order_id: nil,
                menu_item_id: nil,
                quantity: nil,
                price: nil
            )
            order_detail.valid?
            expect(order_detail.errors[:price]).to include("can't be blank")
            expect(order_detail.errors[:quantity]).to include("can't be blank")
            expect(order_detail.errors[:order_id]).to include("can't be blank")
            expect(order_detail.errors[:menu_item_id]).to include("can't be blank")
        end
        
        it 'is invalid create if the customer has not been created or not found' do
            food = MenuItem.create(
                name: 'Nasi Kuning',
                description: 'Lorem ipsum dolor sit amet efficitur lacus hendrerit cras ex integer magna pulvinar egestas phasellus',
                price: 7000.0
            )
            expect { 
                OrderDetail.create!(
                    quantity: 1,
                    order_id: 1,
                    menu_item_id: food.id,
                    price: food.price
                )
            }.to raise_error(ActiveRecord::RecordInvalid)
        end

        it 'is invalid create if the menu item has not been created or not found' do
            customer = Customer.create(
                name: 'Afandi Aziz',
                email: 'afandiaziz46@gmail.com',
                phone: '085777571810'
            )
            order = Order.create(
                customer_id: customer.id
            )
            expect { 
                OrderDetail.create!(
                    quantity: 1,
                    order_id: order.id,
                    menu_item_id: 1,
                    price: 7000.0
                )
            }.to raise_error(ActiveRecord::RecordInvalid)
        end
        
        it 'is valid create new order detail' do
            food1 = MenuItem.create(
                name: 'Nasi Kuning',
                description: 'Lorem ipsum dolor sit amet efficitur lacus hendrerit cras ex integer magna pulvinar egestas phasellus',
                price: 7000.0
            )
            food2 = MenuItem.create(
                name: 'Nasi Uduk',
                description: 'Delicious!',
                price: 5000.0
            )
            customer = Customer.create(
                name: 'Afandi Aziz',
                email: 'afandiaziz46@gmail.com',
                phone: '085777571810'
            )
            order = Order.create(
                customer_id: customer.id
            )
            order_detail1 = OrderDetail.create(
                quantity: 2,
                order_id: order.id, 
                menu_item_id: food1.id,
                price: food1.price
            )
            order_detail2 = OrderDetail.create(
                quantity: 2,
                order_id: order.id, 
                menu_item_id: food2.id,
                price: food2.price
            )
            expect(order_detail1).to be_valid
            expect(order_detail2).to be_valid
        end
    end
end
