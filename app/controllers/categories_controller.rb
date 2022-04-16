class CategoriesController < ApplicationController
    def index
        render json: Category.all, status: :ok
    end
    def create
        category = Category.create(category_params)
        if category.save
            render json: category, status: :created
        else
            render status: :unprocessable_entity
        end
    end
    def update
        category = Category.find(params[:id])
        category.update(category_params)
        render json: category, status: :ok
    end
    def destroy
        Category.destroy(params[:id])
    end

    private
        def category_params
            params.require(:category).permit(:name)
        end
end
