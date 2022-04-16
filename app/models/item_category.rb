class ItemCategory < ApplicationRecord
    has_many :Categories
    belongs_to :MenuItem
end
