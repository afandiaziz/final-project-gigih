class OrderDetailsController < ApplicationController
    def index
        @orders = OrderDetail.all
        jsonResponse(@orders)
    end
    def create
        @order_detail = OrderDetail.create!(params.permit(:quantity, :price, :menu_item_id, :order_id))
        jsonResponse(@order_detail, :created)
    end
    def show
        @order_detail = OrderDetail.find(params[:id])
        @total_price = @order_detail.quantity * @order_detail.price
        @order_detail = @order_detail.attributes
        @order_detail['total_price'] = @total_price
        jsonResponse(@order_detail)
    end
end
