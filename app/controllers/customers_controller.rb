class CustomersController < ApplicationController
    def index
        @customers = Customer.all
        jsonResponse(@customers)
    end
    def show
        @customer = Customer.find(params[:id])
        jsonResponse(@customer)
    end
    def create
        @customer = Customer.create!(customer_params)
        jsonResponse(@customer, :created)
    end
    def update
        @customer = Customer.find(params[:id])
        jsonResponse(@customer.update!(customer_params), :no_content)
    end
    def destroy
        Customer.destroy(params[:id])
        head :no_content
    end

    private
        def customer_params
            params.permit(:name, :email, :phone)
        end
end
