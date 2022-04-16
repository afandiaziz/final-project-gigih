class MenuItemsController < ApplicationController
    def index
        render json: MenuItem.all, status: :ok
    end
    def show
        menu_item = MenuItem.find(params[:id])
        render json: menu_item, status: :ok
    end
    def create
        menu_item = MenuItem.create(menu_item_params)
        if menu_item.save
            render json: menu_item, status: :created
        else
            render json: {
                errors: menu_item.errors
            }, status: 406
        end
    end
    def update
        menu_item = MenuItem.find(params[:id])
        menu_item.update(menu_item_params)
        if menu_item.save
            render json: menu_item, status: :ok
        else
            render json: {
                errors: menu_item.errors
            }, status: 406
        end
    end
    def destroy
        MenuItem.destroy(params[:id])
    end

    private
        def menu_item_params
            params.require(:menu_item).permit(:name, :price, :description)
        end
end
