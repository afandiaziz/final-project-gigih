require 'rails_helper'

RSpec.describe Order, type: :model do
    describe '-- CREATE order' do
        it 'is invalid create without a customer id' do
            order = Order.create(
                customer_id: nil
            )
            order.valid?
            expect(order.errors[:customer_id]).to include("can't be blank")
        end
        
        it 'is invalid create if the customer has not been created or not found' do
            expect { 
                Order.create!(
                    customer_id: 1
                )
            }.to raise_error(ActiveRecord::RecordInvalid)
        end
        
        it 'is valid create new order' do
            customer = Customer.create(
                name: 'Afandi Aziz',
                email: 'afandiaziz46@gmail.com',
                phone: '085777571810'
            )
            order = Order.create(
                customer_id: customer.id
            )
            expect(order.status).to match('NEW')
            expect(customer).to be_valid
        end
    end

    describe '-- UPDATE customer' do
        it 'is invalid update without a status' do
            customer = Customer.create(
                name: 'Afandi Aziz',
                email: 'afandiaziz46@gmail.com',
                phone: '085777571810'
            )
            order = Order.create(
                customer_id: customer.id
            )
            order.update(
                status: nil
            )
            order.valid?
            expect(order.errors[:status]).to include("can't be blank")
        end

        it 'is invalid update without valid status' do
            customer = Customer.create(
                name: 'Afandi Aziz',
                email: 'afandiaziz46@gmail.com',
                phone: '085777571810'
            )
            order = Order.create(
                customer_id: customer.id
            )
            order.update(
                status: 'EXPIRED'
            )
            order.valid?
            expect(order.errors[:status]).to include("EXPIRED is not a valid status")
        end

        it 'is valid update order status' do
            customer = Customer.create(
                name: 'Afandi Aziz',
                email: 'afandiaziz46@gmail.com',
                phone: '085777571810'
            )
            order = Order.create(
                customer_id: customer.id
            )
            order.update(
                status: 'PAID'
            )
            expect(order.status).to match('PAID')
            expect(customer).to be_valid
        end
    end

    describe '-- GET customer' do
        it 'is invalid get without valid id' do
            expect { Order.find(1) }.to raise_error(ActiveRecord::RecordNotFound)
        end
        
        it 'is valid get order with valid id' do
            customer = Customer.create(
                name: 'Afandi Aziz',
                email: 'afandiaziz46@gmail.com',
                phone: '085777571810'
            )
            order1 = Order.create(
                customer_id: customer.id
            )
            order2 = Order.create(
                customer_id: customer.id
            )
            order = Order.find(1)
            expect(order.status).to match('NEW')
            expect(order).to be_valid
        end
    end
end
