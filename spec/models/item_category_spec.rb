require 'rails_helper'

RSpec.describe ItemCategory, type: :model do
    it 'is invalid create without a category id' do
        menuItem = MenuItem.create(
            name: 'Nasi Uduk',
            price: 6500.0
        )
        itemCategory = ItemCategory.create(
            category_id: nil,
            item_id: menuItem.id
        )
        # puts itemCategory.valid?
        # puts itemCategory.inspect
        # puts itemCategory.errors[:category_id]
        expect(itemCategory.valid?).to eq(false)
        expect(itemCategory.errors[:category_id]).to include("can't be blank")
    end

    it 'is invalid create without a item id' do
        category = Category.create(
            name: 'Makanan'
        )
        itemCategory = ItemCategory.create(
            category_id: category.id,
            item_id: nil
        )
        expect(itemCategory.valid?).to eq(false)
        expect(itemCategory.errors[:item_id]).to include("can't be blank")
    end
    
    it 'is invalid create if the category has not been created' do
        menuItem = MenuItem.create(
            name: 'Nasi Uduk',
            price: 6500.0
        )
        expect { 
            ItemCategory.create!(
                category_id: 1,
                item_id: menuItem.id
            )
        }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'is invalid create if the menu item has not been created' do
        category = Category.create(
            name: 'Makanan'
        )
        expect { 
            ItemCategory.create!(
                category_id: category.id,
                item_id: 1
            )
        }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'is valid create item categories' do
        category = Category.create(
            name: 'Makanan'
        )
        menuItem = MenuItem.create(
            name: 'Nasi Uduk',
            price: 6500.0
        )
        itemCategory = ItemCategory.create(
            category_id: category.id,
            item_id: menuItem.id
        )
        expect(itemCategory).to be_valid
    end

    it 'is valid menu item has many item categories' do
        menuItem = MenuItem.create(
            name: 'Kue',
            price: 4000.0
        )
        category1 = Category.create(
            name: 'Makanan'
        )
        category2 = Category.create(
            name: 'Makanan Penutup'
        )
        item_categories = ItemCategory.insert_all([
            { category_id: category1.id, item_id: menuItem.id },
            { category_id: category2.id, item_id: menuItem.id }
        ])

        expect(ItemCategory.count).to eq(2)
    end
end
