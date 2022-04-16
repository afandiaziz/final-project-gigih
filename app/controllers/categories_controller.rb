class CategoriesController < ApplicationController
    def index
        render json: Category.all, status: :ok
    end
    def show
        category = Category.find(params[:id])
        render json: category, status: :ok
    end
    def create
        category = Category.create(category_params)
        if category.save
            render json: category, status: :created
        else
            render json: {
                errors: category.errors
            }, status: 406
        end
    end
    def update
        category = Category.find(params[:id])
        category.update(category_params)
        if category.save
            render json: category, status: :ok
        else
            render json: {
                errors: category.errors
            }, status: 406
        end
    end
    def destroy
        Category.destroy(params[:id])
    end

    private
        def category_params
            params.require(:category).permit(:name)
        end
end
