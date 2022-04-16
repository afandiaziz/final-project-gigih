require 'rails_helper'

RSpec.describe Category, type: :model do
    describe '-- CREATE category' do
        it 'is invalid create without a name' do
            category = Category.create(
                name: nil
            )
            category.valid?
            expect(category.errors[:name]).to include("can't be blank")
        end
        
        it "is invalid create with a duplicate name" do
            category1 = Category.create(
                name: 'Makanan'
            )
            category2 = Category.create(
                name: 'Makanan'
            )
        
            category2.valid?
            expect(category2.errors[:name]).to include("has already been taken")
        end
        
        it 'is valid create new category' do
            category = Category.create(
                name: 'Makanan'
            )
            expect(category).to be_valid
        end
    end

    describe '-- UPDATE category' do
        it 'is invalid update without a name' do
            category = Category.create(
                name: "Makanan"
            )
            category.update(
                name: nil
            )
            category.valid?
            expect(category.errors[:name]).to include("can't be blank")
        end
        
        it "is invalid update with a duplicate name" do
            category1 = Category.create(
                name: 'Makanan'
            )
            category2 = Category.create(
                name: 'Makanan 1'
            )
            category2.update(
                name: 'Makanan'
            )
        
            category2.valid?
            expect(category2.errors[:name]).to include("has already been taken")
        end
        
        it 'is valid update category' do
            category = Category.create(
                name: 'Makanan'
            )
            category.update(
                name: 'Makanan 1'
            )
            expect(category).to be_valid
        end
    end

    describe '-- DELETE category' do
        it 'is invalid delete without valid id' do
            expect{ Category.destroy(1) }.to raise_error(ActiveRecord::RecordNotFound)
        end
        
        it 'is valid delete category' do
            category = Category.create(
                name: 'Makanan'
            )
            category.destroy
            expect(category).to be_valid
        end
    end
end
