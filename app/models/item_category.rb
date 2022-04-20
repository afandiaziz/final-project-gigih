class ItemCategory < ApplicationRecord
    belongs_to :Categories, :class_name => 'Category', :foreign_key => 'category_id'
    belongs_to :MenuItems, :class_name => 'MenuItem', :foreign_key => 'item_id'

    validates :MenuItems, presence: true
    validates :Categories, presence: true
    validates :category_id, presence: true, numericality: true
    validates :item_id, presence: true, numericality: true
end
