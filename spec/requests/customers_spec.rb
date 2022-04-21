require 'rails_helper'

RSpec.describe "Customers", type: :request do
    # Initialize test data
    let!(:customers) { create_list(:customer, 5) }
    let(:customer_id) { customers.first.id }

    describe 'GET /customers' do
        before { get '/customers' }
        it 'return customers' do
            expect(JSON.parse(response.body)).not_to be_empty
            expect(JSON.parse(response.body).size).to eq(5)
        end
        
        it 'return status code 200' do
            expect(response).to have_http_status(200)
        end
    end
    describe 'GET /customers/:id' do
        before { get "/customers/#{customer_id}" }
    
        context 'when the record does not exist' do
            let(:customer_id) { 10 }
        
            it 'return status code 404' do
                expect(response).to have_http_status(404)
            end
        
            it 'return message not found' do
                expect(JSON.parse(response.body)['message']).to match("Couldn't find Customer with 'id'=10")
            end
        end
    
        context 'when the record exists' do
            it 'return the category' do
                expect(JSON.parse(response.body)).not_to be_empty
                expect(JSON.parse(response.body)['id']).to eq(customer_id)
            end
        
            it 'return status code 200' do
                expect(response).to have_http_status(200)
            end
        end
    end
    describe 'POST /customers' do
        context 'the request is invalid fields cant be null' do
            before { 
                post '/customers', params: { 
                    name: nil,
                    email: nil,
                    phone: nil
                } 
            }
        
            it 'return status code 422' do
                expect(response).to have_http_status(422)
            end
        
            it 'return a validation failure message' do
                expect(JSON.parse(response.body)['message']).to match("Name can't be blank")
                expect(JSON.parse(response.body)['message']).to match("Phone can't be blank")
                expect(JSON.parse(response.body)['message']).to match("Email can't be blank")
            end
        end
        context 'the request is invalid with duplicate email address and phone number' do
            before { 
                post '/customers', params: { 
                    name: 'Muhammad Afandi Aziz',
                    email: 'afandiaziz46@gmail.com',
                    phone: '085777571810'
                } 
                post '/customers', params: { 
                    name: 'Afandi Aziz',
                    email: 'afandiaziz46@gmail.com',
                    phone: '085777571810'
                } 
            }
        
            it 'return status code 422' do
                expect(response).to have_http_status(422)
            end
        
            it 'return a validation failure message' do
                expect(JSON.parse(response.body)['message']).to match("Email has already been taken")
                expect(JSON.parse(response.body)['message']).to match("Phone has already been taken")
            end
        end

        context 'the request post is valid' do
            before { 
                post '/customers', params: { 
                    name: 'Afandi Aziz',
                    email: 'afandiaziz46@gmail.com',
                    phone: '085777571810'
                } 
            }
        
            it 'created a customer' do
                expect(JSON.parse(response.body)['name']).to eq('Afandi Aziz')
                expect(JSON.parse(response.body)['email']).to eq('afandiaziz46@gmail.com')
                expect(JSON.parse(response.body)['phone']).to eq('085777571810')
            end
        
            it 'return status code 201' do
                expect(response).to have_http_status(201)
            end
        end
    end
    describe 'PUT /customers/:id' do
        context 'when the record exists' do
            before { 
                put "/customers/#{customer_id}", params: { 
                    name: 'Fandi' 
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
    describe 'DELETE /customers/:id' do
        before { delete "/customers/#{customer_id}" }
    
        it 'return status code 204' do
            expect(response).to have_http_status(204)
        end
    end
end
