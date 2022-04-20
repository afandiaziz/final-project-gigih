class Customer < ApplicationRecord
    has_many :order

    validates :name, presence: true
    validates :phone, presence: true, uniqueness: true
    validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP} 
end
