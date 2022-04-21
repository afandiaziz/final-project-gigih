class CategoriesController < ApplicationController
    def index
        @categories = Category.all
        jsonResponse(@categories)
    end
    def show
        @category = Category.find(params[:id])
        jsonResponse(@category)
    end
    def create
        @category = Category.create!(category_params)
        jsonResponse(@category, :created)
    end
    def update
        @category = Category.find(params[:id])
        jsonResponse(@category.update(category_params), :no_content)
    end
    def destroy
        Category.destroy(params[:id])
        head :no_content
    end

    private
        def category_params
            params.permit(:name)
        end
end
