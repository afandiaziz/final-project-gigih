class Order < ApplicationRecord
    belongs_to :customer
    has_many :order_details

    validates :customer_id, presence: true, numericality: true
    validates :status, presence: true, inclusion: { 
        in: %w(NEW PAID CANCELED),
        message: "%{value} is not a valid status" 
    }
    
    def total_price()
        total = 0
        order_details.each do |order_detail|
            total += order_detail.price * order_detail.quantity
        end
        return total
    end
end
