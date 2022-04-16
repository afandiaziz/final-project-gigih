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
      
      it 'returns status code 200' do
          expect(response).to have_http_status(200)
      end
  end
end
