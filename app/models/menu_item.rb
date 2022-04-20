class MenuItem < ApplicationRecord
    has_many :item_categories, :foreign_key => 'item_id'
    has_many :order_details
    
    validates :name, presence: true, uniqueness: true
    validates :description, length: { maximum: 150 }
    validates :price, presence: true, numericality: true, comparison: { greater_than_or_equal_to: 0.01 }
end
