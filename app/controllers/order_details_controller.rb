class OrderDetailsController < ApplicationController
    def index
        @orders = OrderDetail.all
        jsonResponse(@orders)
    end
    def create
        @order = Order.create!(params.permit(:quantity, :price, :menu_item_id, :order_id))
        jsonResponse(@order, :created)
    end
    def show
        @order = Order.find(params[:id])
        jsonResponse(@order)
    end
end
