class MenuItemsController < ApplicationController
    def index
        @menu_items = MenuItem.select("menu_items.*, GROUP_CONCAT(categories.name) as categories")
                        .joins("LEFT JOIN item_categories on item_categories.item_id = menu_items.id")
                        .joins("LEFT JOIN categories ON item_categories.category_id = categories.id")
                        .group("menu_items.id")
        jsonResponse(@menu_items)
    end
    def show
        @menu_item = MenuItem.find(params[:id])
        jsonResponse(@menu_item)
    end
    def create
        @menu_item = MenuItem.create!(menu_item_params)
        jsonResponse(@menu_item, :created)
    end
    def update
        @menu_item = MenuItem.find(params[:id])
        @menu_item.update(menu_item_params)
        jsonResponse(@menu_item.update!(menu_item_params), :no_content)
    end
    def destroy
        MenuItem.destroy(params[:id])
        head :no_content
    end

    private
        def menu_item_params
            params.permit(:name, :price, :description)
        end
end
