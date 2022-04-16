class MenuItem < ApplicationRecord
    has_many :ItemCategories
    # validates_associated :ItemCategories
    
    validates :name, presence: true, uniqueness: true
    validates :description, length: { maximum: 150 }
    validates :price, presence: true, numericality: true, comparison: { greater_than_or_equal_to: 0.01 }
end
