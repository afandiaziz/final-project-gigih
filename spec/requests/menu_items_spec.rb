require 'rails_helper'

RSpec.describe "MenuItems", type: :request do
    # Initialize test data
    let!(:menu_items) { create_list(:menu_item, 2) }
    let(:menuitem_id) { MenuItem.first.id }

    describe 'GET /menu_items' do
        before { get '/menu_items' }
        it 'return menu items' do
            expect(JSON.parse(response.body)).not_to be_empty
            expect(JSON.parse(response.body).size).to eq(2)
        end
        
        it 'return status code 200' do
            expect(response).to have_http_status(200)
        end
    end
    describe 'GET /menu_items/:id' do
        before { get "/menu_items/#{menuitem_id}" }
    
        context 'when the record exists' do
            it 'return the menu item' do
                expect(JSON.parse(response.body)).not_to be_empty
                expect(JSON.parse(response.body)['id']).to eq(menuitem_id)
            end
        
            it 'return status code 200' do
                expect(response).to have_http_status(200)
            end
        end
    
        context 'when the record does not exist' do
            let(:menuitem_id) { 100 }
        
            it 'return status code 404' do
                expect(response).to have_http_status(404)
                expect(JSON.parse(response.body)['message']).to match("Couldn't find MenuItem with 'id'=100")
            end
        end
    end
    describe 'POST /menu_items' do
        context 'the request is invalid' do
            it "Name can't be blank" do
                post '/menu_items', params: { 
                    name: nil,
                    price: 1000.0,
                    description: 'Lorem ipsum dolor sit amet efficitur lacus hendrerit cras ex integer magna pulvinar egestas phasellus' 
                }
                expect(response).to have_http_status(422)
                expect(JSON.parse(response.body)['message']).to match("Validation failed: Name can't be blank")
            end
        
            it "Price must be greater than or equal to 0.01" do
                post '/menu_items', params: { 
                    name: 'Nasi Kucing',
                    price: 0.005,
                    description: 'Lorem ipsum dolor sit amet efficitur lacus hendrerit cras ex integer magna pulvinar egestas phasellus' 
                }
                expect(response).to have_http_status(422)
                expect(JSON.parse(response.body)['message']).to match("Validation failed: Price must be greater than or equal to 0.01")
            end

            it "Price is not a number" do
                post '/menu_items', params: { 
                    name: 'Nasi Kucing',
                    price: "Lima Ribu Rupiah"
                }
                expect(response).to have_http_status(422)
                expect(JSON.parse(response.body)['message']).to match("Validation failed: Price is not a number")
            end

            it "Description is too long (maximum is 150 characters)" do
                post '/menu_items', params: { 
                    name: 'Nasi Kucing',
                    price: 6000.0,
                    description: 'Lorem ipsum dolor sit amet rhoncus ut cursus facilisi suscipit et maecenas tempus arcu himenaeos ultrices placerat sodales viverra taciti volutpat malesuada eros nostra'
                }
                expect(response).to have_http_status(422)
                expect(JSON.parse(response.body)['message']).to match("Validation failed: Description is too long (maximum is 150 characters)")
            end

            it "can't duplicate name" do
                post '/menu_items', params: { 
                    name: 'Nasi Kucing',
                    price: 6000.0,
                }
                post '/menu_items', params: { 
                    name: 'Nasi Kucing',
                    price: 9000.0,
                    description: "Nasi kucing yang enak"
                }
                expect(response).to have_http_status(422)
                expect(JSON.parse(response.body)['message']).to match("Validation failed: Name has already been taken")
            end
        end

        context 'the request is valid' do
            it 'created a menu item' do
                post '/menu_items', params: {  
                    name: 'Nasi Kuning',
                    description: 'Lorem ipsum dolor sit amet efficitur lacus hendrerit cras ex integer magna pulvinar egestas phasellus',
                    price: 7000.0
                } 
                expect(JSON.parse(response.body)['name']).to eq('Nasi Kuning')
                expect(response).to have_http_status(201)
            end
        
            it 'created a menu item without description' do
                post '/menu_items', params: {  
                    name: 'Nasi Uduk',
                    price: 7500.0
                } 
                expect(JSON.parse(response.body)['name']).to eq('Nasi Uduk')
                expect(response).to have_http_status(201)
            end
        end
    end
    describe 'PUT /menu_items/:id' do
        context 'when the record exists' do
            before { put "/menu_items/#{menuitem_id}", params: { price: 7000.0 } }
        
            it 'updated the record' do
                expect(response.body).to be_empty
            end
        
            it 'return status code 204' do
                expect(response).to have_http_status(204)
            end
        end
    end
    describe 'DELETE /menu_items/:id' do
        before { delete "/menu_items/#{menuitem_id}" }
    
        it 'return status code 204' do
            expect(response).to have_http_status(204)
        end
    end
end
