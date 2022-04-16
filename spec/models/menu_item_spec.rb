require 'rails_helper'

RSpec.describe MenuItem, type: :model do
    describe '-- CREATE menuItem' do
        it 'is invalid create without a name' do
            menuItem = MenuItem.create(
                name: nil,
                price: 1000.0,
                description: 'Lorem ipsum dolor sit amet efficitur lacus hendrerit cras ex integer magna pulvinar egestas phasellus'
            )
            menuItem.valid?
            expect(menuItem.errors[:name]).to include("can't be blank")
        end

        it 'is invalid create without a price' do
            menuItem = MenuItem.new(
                name: "Kerak Telor",
                description: "Lorem ipsum dolor sit amet",
                price: nil
            )
            menuItem.valid?
            expect(menuItem.errors[:price]).to include("can't be blank")
        end

        it 'is invalid non numeric values for price' do
            menuItem = MenuItem.new(
                name: "Kerak Telor",
                description: "Betawi traditional spicy omelette made from glutinous rice cooked with egg and served with serundeng.",
                price: "Lima Ribu Rupiah"
            )
            menuItem.valid?
            expect(menuItem.errors[:price]).to include("is not a number")
        end
        
        it 'is invalid price less than 0.01' do
            menuItem = MenuItem.new(
                name: "Cimin",
                description: 'Aci di goreng',
                price: 0.005
            )
            menuItem.valid?
            expect(menuItem.errors[:price]).to include("must be greater than or equal to 0.01")
        end
        
        it 'is invalid length name greater than 150 characters' do
            menuItem = MenuItem.new(
                name: "Kerak Telor",
                price: 3000.0,
                description: 'Lorem ipsum dolor sit amet rhoncus ut cursus facilisi suscipit et maecenas tempus arcu himenaeos ultrices placerat sodales viverra taciti volutpat malesuada eros nostra'
            )
            menuItem.valid?
            expect(menuItem.errors[:description]).to include("is too long (maximum is 150 characters)")
        end
        
        
        it "is invalid create with a duplicate name" do
            menuItem1 = MenuItem.create(
                name: "Nasi Uduk",
                description: "Betawi style steamed rice cooked in coconut milk. Delicious!",
                price: 7000.0
            )
            menuItem2 = MenuItem.create(
                name: "Nasi Uduk",
                description: "Just with a different description.",
                price: 10000.0
            )
        
            menuItem2.valid?
            expect(menuItem2.errors[:name]).to include("has already been taken")
        end
        
        it 'is valid create new menuItem without description' do
            menuItem = MenuItem.create(
                name: 'Nasi Uduk',
                price: 6500.0
            )
            expect(menuItem).to be_valid
        end

        it 'is valid create new menuItem' do
            menuItem = MenuItem.create(
                name: 'Nasi Kuning',
                description: 'Lorem ipsum dolor sit amet efficitur lacus hendrerit cras ex integer magna pulvinar egestas phasellus',
                price: 7000.0
            )
            expect(menuItem).to be_valid
        end
    end

    describe '-- UPDATE menuItem' do
        it 'is invalid update without valid id' do
            expect { 
                menuItem = MenuItem.find(1)
                menuItem.update(
                    name: 'Nasi Uduk',
                    price: 6500.0
                ) 
            }.to raise_error(ActiveRecord::RecordNotFound)
        end

        it 'is invalid update without a name' do
            menuItem = MenuItem.create(
                name: 'Nasi Uduk',
                price: 6500.0
            )
            menuItem.update(
                name: nil
            )
            menuItem.valid?
            expect(menuItem.errors[:name]).to include("can't be blank")
        end
        
        it "is invalid update with a duplicate name" do
            menuItem1 = MenuItem.create(
                name: 'Nasi Uduk',
                price: 6500.0
            )
            menuItem2 = MenuItem.create(
                name: 'Nasi Kuning',
                price: 7000.0
            )
            menuItem2.update(
                name: 'Nasi Uduk'
            )
        
            menuItem2.valid?
            expect(menuItem2.errors[:name]).to include("has already been taken")
        end
        
        it 'is valid update menuItem' do
            menuItem = MenuItem.create(
                name: 'Nasi Kuning',
                description: 'Lorem ipsum dolor sit amet efficitur lacus hendrerit cras ex integer magna pulvinar egestas phasellus',
                price: 7000.0
            )
            menuItem.update(
                name: 'Nasi Uduk',
                price: 6500.0
            )
            expect(menuItem).to be_valid
        end
    end

    describe '-- DELETE menuItem' do
        it 'is invalid delete without valid id' do
            expect { MenuItem.destroy(1) }.to raise_error(ActiveRecord::RecordNotFound)
        end
        
        it 'is valid delete menuItem' do
            menuItem = MenuItem.create(
                name: 'Nasi Kuning',
                price: 7000.0
            )
            menuItem.destroy
            expect(menuItem).to be_valid
        end
    end

    describe '-- GET menuItem' do
        it 'is invalid get without valid id' do
            expect { MenuItem.find(1) }.to raise_error(ActiveRecord::RecordNotFound)
        end
        
        it 'is valid get menuItem with valid id' do
            MenuItem.create(
                name: 'Nasi Kuning',
                price: 8000.0
            )
            menuItem = MenuItem.find(1)
            expect(menuItem).to be_valid
        end
    end
end
