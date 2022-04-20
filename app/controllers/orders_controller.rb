class OrdersController < ApplicationController
    def index
        @orders = Order.all
        jsonResponse(@orders)
    end
    def show
        @order = Order.find(params[:id])
        jsonResponse(@order)
    end
    def create
        @order = Order.create!(params.permit(:customer_id))
        jsonResponse(@order, :created)
    end
    def update
        @order = Order.find(params[:id])
        @order.update(params.permit(:status))
        head :no_content
    end
end
