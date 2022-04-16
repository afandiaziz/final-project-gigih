require 'rails_helper'

RSpec.describe Category, type: :model do
    it 'is invalid without a name' do
        category = Category.new(
            name: nil,
        )
        category.valid?
        expect(category.errors[:name]).to include("can't be blank")
    end
    
    it 'is valid new category' do
        category = Category.new(
            name: 'Makanan'
        )
        expect(category).to be_valid
    end

    # it "is invalid with a duplicate name" do
    #     foodCategory1 = Category.create(
    #     name: 'Makanan'
    #     )
        
    #     foodCategory2 = Category.new(
    #     name: 'Makanan'
    #     )

    #     foodCategory2.valid?
        
    #     expect(foodCategory2.errors[:name]).to include("has already been taken")
    # end
end
