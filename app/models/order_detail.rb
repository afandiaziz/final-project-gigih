class OrderDetail < ApplicationRecord
    belongs_to :order
    belongs_to :menu_item

    validates :order_id, presence: true, numericality: true
    validates :quantity, presence: true, numericality: true
    validates :menu_item_id, presence: true, numericality: true
    validates :price, presence: true, numericality: true, comparison: { greater_than_or_equal_to: 0.01 }
end
