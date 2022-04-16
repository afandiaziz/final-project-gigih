class Category < ApplicationRecord
    has_many :ItemCategories
    validates :name, presence: true, uniqueness: true
end
