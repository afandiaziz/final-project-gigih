require 'rails_helper'

RSpec.describe "ItemCategories", type: :request do
    let!(:menuItems) { create_list(:menu_item, 2) }
    let!(:categories) { create_list(:category, 5) }
    let!(:item_categories) {
        ItemCategory.insert_all([
            { category_id: Faker::Number.between(from: 1, to: 5), item_id: Faker::Number.between(from: 1, to: 2) },
            { category_id: Faker::Number.between(from: 1, to: 5), item_id: Faker::Number.between(from: 1, to: 2) },
            { category_id: Faker::Number.between(from: 1, to: 5), item_id: Faker::Number.between(from: 1, to: 2) },
            { category_id: Faker::Number.between(from: 1, to: 5), item_id: Faker::Number.between(from: 1, to: 2) },
            { category_id: Faker::Number.between(from: 1, to: 5), item_id: Faker::Number.between(from: 1, to: 2) },
        ])
    }
    let(:itemCategory_id) { ItemCategory.first.id }
    # let!(:item_categories) { create_list(:item_category, 2) }
    # let!(:item_categories) { create(:item_category) }
    describe "GET /index" do
        before { get '/item_categories' }
        it 'return item categories' do
            expect(JSON.parse(response.body)).not_to be_empty
            expect(JSON.parse(response.body).size).to eq(5)
        end
        
        it 'return status code 200' do
            expect(response).to have_http_status(200)
        end
    end
    describe 'GET /item_categories/:id' do
        before { get "/item_categories/#{itemCategory_id}" }
    
        context 'when the record exists' do
            it 'return the item category' do
                expect(JSON.parse(response.body)).not_to be_empty
                expect(JSON.parse(response.body)['id']).to eq(itemCategory_id)
            end
        
            it 'return status code 200' do
                expect(response).to have_http_status(200)
            end
        end
    
        context 'when the record does not exist' do
            let(:itemCategory_id) { 100 }
        
            it 'return status code 404' do
                expect(response).to have_http_status(404)
                expect(JSON.parse(response.body)['message']).to match("Couldn't find ItemCategory with 'id'=100")
            end
        end
    end

    describe 'DELETE /item_categories/:id' do
        before { delete "/item_categories/#{itemCategory_id}" }
    
        it 'return status code 204' do
            expect(response).to have_http_status(204)
        end
    end
end
