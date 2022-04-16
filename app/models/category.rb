class Category < ApplicationRecord
    has_many :ItemCategories, :class_name => 'ItemCategory', :foreign_key => 'category_id'
    validates_associated :ItemCategories
    # has_many :ItemCategories
    validates :name, presence: true, uniqueness: true
end
