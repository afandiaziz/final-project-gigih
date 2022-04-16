class ItemCategoriesController < ApplicationController
    def index
        render json: ItemCategory.all, status: :ok
    end
    def show
        itemCategory = ItemCategory.find(params[:id])
        render json: itemCategory, status: :ok
    end
    def create
        itemCategory = ItemCategory.create(item_category_params)
        if itemCategory.save
            render json: itemCategory, status: :created
        else
            render json: {
                errors: itemCategory.errors
            }, status: 406
        end
    end
    def update
        itemCategory = ItemCategory.find(params[:id])
        itemCategory.update(item_category_params)
        if itemCategory.save
            render json: itemCategory, status: :ok
        else
            render json: {
                errors: itemCategory.errors
            }, status: 406
        end
    end
    def destroy
        ItemCategory.destroy(params[:id])
    end

    private
        def item_category_params
            params.require(:item_category).permit(:item_id, :category_id)
        end
end
