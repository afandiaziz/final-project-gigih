class Category < ApplicationRecord
    has_many :ItemCategories
    # validates_associated :ItemCategories
    validates :name, presence: true, uniqueness: true
end
