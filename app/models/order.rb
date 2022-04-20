class Order < ApplicationRecord
    belongs_to :customer
    has_many :order_details

    validates :customer_id, presence: true, numericality: true
    validates :status, presence: true, inclusion: { 
        in: %w(NEW PAID CANCELED),
        message: "%{value} is not a valid status" 
    }
end
