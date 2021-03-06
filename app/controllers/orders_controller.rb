class OrdersController < ApplicationController
    def index
        @orders = Order.all
        jsonResponse(@orders)
    end
    def show
        @order = Order.find(params[:id])
        totalPrice = @order.total_price
        @order = @order.attributes
        @order['total_price'] = totalPrice

        jsonResponse(@order)
    end
    def create
        @order = Order.create!(params.permit(:customer_id))
        jsonResponse(@order, :created)
    end
    def update
        @order = Order.find(params[:id])
        jsonResponse(@order.update!(params.permit(:status)), :no_content)
    end

    def exceed_limit
        dueDate = DateTime.parse(Date.today.to_s + " 17:00:00")
        @orders = Order.where(status: 'NEW').where("created_at < ?", dueDate)
        @orders.update_all(status: 'CANCELED')
        jsonResponse( @orders, :no_content )
    end

    def report
        if params[:date_start]
            date_start = Date.parse(params[:date_start])

            if params[:date_end]
                date_end = Date.parse(params[:date_end])
            else 
                date_end = Date.parse(params[:date_start])
            end
        else 
            date_end = Date.today
            date_start = Date.today
        end

        orders = Order.select("orders.*, 
                        SUM(order_details.price * order_details.quantity) as total_price, 
                        customers.name as customer_name, 
                        customers.email as customer_email, 
                        customers.phone as customer_phone
                    ")
                    .joins("LEFT JOIN customers on orders.customer_id = customers.id")
                    .joins("LEFT JOIN order_details on orders.id = order_details.order_id")
                    .where(created_at: date_start.midnight..date_end.end_of_day)
                    .group("orders.id")

        if params[:email]
            orders = orders.where("customer_email = ?", params[:email])
        end
        if params[:status]
            orders = orders.where(status: params[:status])
        end
        if params[:price]
            orders = orders.having("total_price >= ?", params[:price].to_f)
        end
        
        results = []
        orders.each_with_index do |order, index|
            orderAttributes = order.attributes
            orderAttributes['order_details'] = OrderDetail.select('order_details.*, menu_items.name as menu_item_name').where(order_id: order.id).joins("LEFT JOIN menu_items on menu_items.id = order_details.menu_item_id")
            results.push(orderAttributes)
        end

        jsonResponse(results)
    end
end
