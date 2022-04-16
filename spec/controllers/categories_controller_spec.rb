require 'rails_helper'

RSpec.describe CategoriesController do
    describe 'GET #index' do
        context 'without params[:letter]' do
            it "populates an array of all foods" do 
                makanan = create(:category, name: "Makanan")
                minuman = create(:category, name: "Minuman")
                get :index
                expect(assigns(:categories)).to match_array([makanan, minuman])
            end

            # it "renders the :index template" do
            #     get :index
            #     expect(response).to render_template :index
            # end
        end
    end
end