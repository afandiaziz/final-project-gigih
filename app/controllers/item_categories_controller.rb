class ItemCategoriesController < ApplicationController
    
    def index
        @item_categories = ItemCategory.all
        jsonResponse(@item_categories)
    end
    def show
        @item_category = ItemCategory.find(params[:id])
        jsonResponse(@item_category)
    end
    def create
        @item_category = ItemCategory.create!(item_category_params)
        jsonResponse(@item_category, :created)
    end
    def update
        @item_category = ItemCategory.find(params[:id])
        jsonResponse(@item_category.update!(item_category_params), :no_content)
    end
    def destroy
        ItemCategory.destroy(params[:id])
        head :no_content
    end

    private
        def item_category_params
            params.permit(:item_id, :category_id)
        end
end
