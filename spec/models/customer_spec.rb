require 'rails_helper'

RSpec.describe Customer, type: :model do
    describe '-- CREATE customer' do
        it 'is invalid create without a name' do
            customer = Customer.create(
                name: nil,
                email: 'afandiaziz46@gmail.com',
                phone: '085777571810'
            )
            customer.valid?
            expect(customer.errors[:name]).to include("can't be blank")
        end

        it 'is invalid create without an email address' do
            customer = Customer.create(
                name: 'Afandi Aziz',
                email: nil,
                phone: '085777571810'
            )
            customer.valid?
            expect(customer.errors[:email]).to include("can't be blank")
        end

        it 'is invalid create without a phone number' do
            customer = Customer.create(
                name: 'Afandi Aziz',
                email: 'afandiaziz46@gmail.com',
                phone: nil
            )
            customer.valid?
            expect(customer.errors[:phone]).to include("can't be blank")
        end
        
        it 'is invalid create without a valid email address' do
            customer = Customer.create(
                name: 'Afandi Aziz',
                email: 'afandiaziz',
                phone: '085777571810'
            )
            customer.valid?
            expect(customer.errors[:email]).to include("is invalid")
        end

        it "is invalid create with a duplicate email" do
            customer1 = Customer.create(
                name: 'Muhammad Afandi Aziz',
                email: 'afandiaziz46@gmail.com',
                phone: '085777571810'
            )
            customer2 = Customer.create(
                name: 'Afandi Aziz',
                email: 'afandiaziz46@gmail.com',
                phone: '0817154675'
            )
        
            customer2.valid?
            expect(customer2.errors[:email]).to include("has already been taken")
        end

        it "is invalid create with a duplicate phone number" do
            customer1 = Customer.create(
                name: 'Afandi Aziz',
                email: 'afandiaziz46@gmail.com',
                phone: '085777571810'
            )
            customer2 = Customer.create(
                name: 'Muhammad Afandi Aziz',
                email: 'afandiaziz42@gmail.com',
                phone: '085777571810'
            )
        
            customer2.valid?
            expect(customer2.errors[:phone]).to include("has already been taken")
        end
        
        it 'is valid create new customer' do
            customer = Customer.create(
                name: 'Afandi Aziz',
                email: 'afandiaziz46@gmail.com',
                phone: '085777571810'
            )
            expect(customer).to be_valid
        end
    end
    
    describe '-- UPDATE customer' do
        it 'is invalid update without a name' do
            customer = Customer.create(
                name: 'Afandi Aziz',
                email: 'afandiaziz46@gmail.com',
                phone: '085777571810'
            )
            customer.update(
                name: nil
            )
            customer.valid?
            expect(customer.errors[:name]).to include("can't be blank")
        end

        it 'is invalid update without an email address' do
            customer = Customer.create(
                name: 'Afandi Aziz',
                email: 'afandiaziz46@gmail.com',
                phone: '085777571810'
            )
            customer.update(
                email: nil
            )
            customer.valid?
            expect(customer.errors[:email]).to include("can't be blank")
        end

        it 'is invalid update without valid email address' do
            customer = Customer.create(
                name: 'Afandi Aziz',
                email: 'afandiaziz46@gmail.com',
                phone: '085777571810'
            )
            customer.update(
                email: 'afandiaziz'
            )
            customer.valid?
            expect(customer.errors[:email]).to include("is invalid")
        end

        it 'is invalid update without a phone number' do
            customer = Customer.create(
                name: 'Afandi Aziz',
                email: 'afandiaziz46@gmail.com',
                phone: '085777571810'
            )
            customer.update(
                phone: nil
            )
            customer.valid?
            expect(customer.errors[:phone]).to include("can't be blank")
        end
        
        it "is invalid update with a duplicate email" do
            customer1 = Customer.create(
                name: 'Afandi Aziz',
                email: 'afandiaziz46@gmail.com',
                phone: '085777571810'
            )
            customer2 = Customer.create(
                name: 'Muhammad Afandi Aziz',
                email: 'afandiaziz42@gmail.com',
                phone: '0817154675'
            )
            customer2.update(
                email: 'afandiaziz46@gmail.com'
            )
        
            customer2.valid?
            expect(customer2.errors[:email]).to include("has already been taken")
        end
        
        it "is invalid update with a duplicate phone number" do
            customer1 = Customer.create(
                name: 'Afandi Aziz',
                email: 'afandiaziz46@gmail.com',
                phone: '085777571810'
            )
            customer2 = Customer.create(
                name: 'Muhammad Afandi Aziz',
                email: 'afandiaziz42@gmail.com',
                phone: '0817154675'
            )
            customer1.update(
                phone: '0817154675'
            )
        
            customer1.valid?
            expect(customer1.errors[:phone]).to include("has already been taken")
        end
        
        it 'is invalid update without valid id' do
            expect { 
                customer = Customer.find(1)
                customer.update(
                    name: 'Fandi'
                ) 
            }.to raise_error(ActiveRecord::RecordNotFound)
        end

        it 'is valid update customer' do
            customer = Customer.create(
                name: 'Afandi Aziz',
                email: 'afandiaziz46@gmail.com',
                phone: '085777571810'
            )
            customer.update(
                name: 'Muhammad Afandi Aziz',
                email: 'afandiaziz42@gmail.com',
                phone: '085777571810'

            )
            expect(customer).to be_valid
        end
    end

    describe '-- DELETE customer' do
        it 'is invalid delete without valid id' do
            expect { Customer.destroy(1) }.to raise_error(ActiveRecord::RecordNotFound)
        end
        
        it 'is valid delete customer' do
            customer = Customer.create(
                name: 'Afandi Aziz',
                email: 'afandiaziz46@gmail.com',
                phone: '085777571810'
            )
            customer.destroy
            expect(customer).to be_valid
        end
    end

    describe '-- GET customer' do
        it 'is invalid get without valid id' do
            expect { Customer.find(1) }.to raise_error(ActiveRecord::RecordNotFound)
        end
        
        it 'is valid get customer with valid id' do
            Customer.create(
                name: 'Afandi Aziz',
                email: 'afandiaziz46@gmail.com',
                phone: '085777571810'
            )
            customer = Customer.find(1)
            expect(customer).to be_valid
        end
    end
end
