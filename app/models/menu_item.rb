class MenuItem < ApplicationRecord
    has_many :ItemCategories
    validates_associated :ItemCategories
end
