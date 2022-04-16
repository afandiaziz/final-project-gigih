require 'rails_helper'

RSpec.describe "Categories", type: :request do
    # Initialize test data
    let!(:categories) { create_list(:category, 5) }
    let(:category_id) { categories.first.id }

    describe 'GET /categories' do
        before { get '/categories' }
        it 'return articles' do
            expect(JSON.parse(response.body)).not_to be_empty
            expect(JSON.parse(response.body).size).to eq(5)
        end
        
        it 'return status code 200' do
            expect(response).to have_http_status(200)
        end
    end
    describe 'GET /categories/:id' do
        before { get "/categories/#{category_id}" }
    
        context 'when the record exists' do
            it 'return the category' do
                expect(JSON.parse(response.body)).not_to be_empty
                expect(JSON.parse(response.body)['id']).to eq(category_id)
            end
        
            it 'return status code 200' do
                expect(response).to have_http_status(200)
            end
        end
    
        context 'when the record does not exist' do
            let(:category_id) { 10 }
        
            it 'return status code 404' do
                expect(response).to have_http_status(404)
            end
        
            it 'return message not found' do
                expect(response.body).to match("{\"message\":\"Couldn't find Category with 'id'=10\"}")
            end
        end
    end
end
