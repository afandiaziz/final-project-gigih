class ItemCategory < ApplicationRecord
    belongs_to :Categories
    belongs_to :MenuItems
end
