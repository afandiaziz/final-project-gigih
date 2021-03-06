require 'rails_helper'

RSpec.describe "Orders", type: :request do
    let!(:menu_items) { create_list(:menu_item, 5) }
    let!(:customers) { create_list(:customer, 10) }
    let!(:orders) { create_list(:order, 20) }
    let(:order_id) { orders.first.id }
    let!(:order_details) {
        for i in 1..20 do
            totalOrderDetail = Faker::Number.between(from: 1, to: 3)
            menuItemSelected = []
            for j in 1..totalOrderDetail do
                menuitem_id = Faker::Number.between(from: 1, to: 5)
                if !menuItemSelected.include?(menuitem_id)
                    menuItemSelected.push(menuitem_id)
                    create(:order_detail, order_id: i, menu_item_id: menuitem_id)
                end
            end
        end
    }
    
    describe 'GET /orders' do
        before { get '/orders' }
        it 'return orders' do
            expect(JSON.parse(response.body)).not_to be_empty
            expect(JSON.parse(response.body).size).to eq(20)
        end
        
        it 'return status code 200' do
            expect(response).to have_http_status(200)
        end
    end
    describe 'GET /orders/:id' do
        before { get "/orders/#{order_id}" }
    
        context 'when the record does not exist' do
            let(:order_id) { 100 }
        
            it 'return status code 404' do
                expect(response).to have_http_status(404)
            end
        
            it 'return message not found' do
                expect(JSON.parse(response.body)['message']).to match("Couldn't find Order with 'id'=100")
            end
        end
    
        context 'when the record exists' do
            it 'return the order' do
                expect(JSON.parse(response.body)).not_to be_empty
                expect(JSON.parse(response.body)['id']).to eq(order_id)
            end
        
            it 'return status code 200' do
                expect(response).to have_http_status(200)
            end
        end
    end
    describe 'POST /orders' do
        context 'the request is invalid fields cant be null' do
            before { 
                post '/orders', params: { 
                    customer_id: nil
                } 
            }
        
            it 'return status code 422' do
                expect(response).to have_http_status(422)
            end
        
            it 'return a validation failure message' do
                expect(JSON.parse(response.body)['message']).to match("Customer can't be blank")
            end
        end

        context 'the request post is valid' do
            before { 
                post '/orders', params: { 
                    customer_id: Faker::Number.between(from: 1, to: 10)
                } 
            }
        
            it 'created a order' do
                expect(response).to have_http_status(201)
            end
        end
    end
    describe 'PUT /orders/:id' do
        context 'value status is not valid' do
            before { 
                put "/orders/#{order_id}", params: { 
                    status: 'EXPIRED'
                } 
            }
            it 'return status code 422' do
                expect(response).to have_http_status(422)
            end
            it 'return a validation failure message' do
                expect(JSON.parse(response.body)['message']).to match("EXPIRED is not a valid status")
            end
        end
        context 'when the record exists' do
            before { 
                put "/orders/#{order_id}", params: { 
                    status: 'PAID'
                } 
            }
        
            it 'updated the record' do
                expect(response.body).to be_empty
            end
        
            it 'return status code 204' do
                expect(response).to have_http_status(204)
            end
        end
    end
    describe 'GET /report' do
        before { get '/report' }
        it 'return report' do
            expect(JSON.parse(response.body)).not_to be_empty
            expect(response).to have_http_status(200)
        end
    end
    describe 'PUT /orders-exceed-limit' do
        before { put '/orders-exceed-limit' }
        it 'return status code 204' do
            expect(response.body).to be_empty
            expect(response).to have_http_status(204)
        end
    end
end
