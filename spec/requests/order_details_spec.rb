require 'rails_helper'

RSpec.describe "OrderDetails", type: :request do
    let!(:menu_items) { create_list(:menu_item, 2) }
    let!(:customers) { create_list(:customer, 10) }
    let!(:orders) { create_list(:order, 20) }
    let!(:order_details) {
        for i in 1..20 do
            # create(:order_detail, order_id: i, product_id: i, quantity: i)
            create_list(:order_detail, Faker::Number.between(from: 1, to: 5), order_id: i)
        end
    }
    let(:order_detail_id) { OrderDetail.first.id }

    describe 'GET ALL /order_details' do
        before { get '/order_details' }
        it 'return order details' do
            expect(JSON.parse(response.body)).not_to be_empty
        end
        it 'return status code 200' do
            expect(response).to have_http_status(200)
        end
    end
    describe 'GET /order_details/:id' do
        before { get "/order_details/#{order_detail_id}" }
    
        context 'when the record does not exist' do
            let(:order_detail_id) { 100 }
        
            it 'return status code 404' do
                expect(response).to have_http_status(404)
            end
        
            it 'return message not found' do
                expect(JSON.parse(response.body)['message']).to match("Couldn't find OrderDetail with 'id'=100")
            end
        end
    
        context 'when the record exists' do
            it 'return the order detail' do
                puts JSON.parse(response.body)
                # expect(JSON.parse(response.body)).not_to be_empty
                # expect(JSON.parse(response.body)['id']).to eq(order_detail_id)
            end
        
            # it 'return status code 200' do
            #     expect(response).to have_http_status(200)
            # end
        end
    end
    describe 'POST /orders' do
        context 'the request post is valid' do
            before { 
                post '/order_details', params: { 
                    quantity: Faker::Number.between(from: 1, to: 3),
                    price: Faker::Commerce.price(range: 2000..100000.0),
                    menu_item_id: Faker::Number.between(from: 1, to: 2),
                    order_id: Faker::Number.between(from: 1, to: 20)
                } 
            }
        
            it 'created a order detail' do
                expect(response).to have_http_status(201)
            end
        end
    end
end
