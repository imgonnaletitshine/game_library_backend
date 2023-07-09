class CategoriesController < ApplicationController
  def index
    categories = Category.all
    render json: { categories: categories }
  end

  def create
    Category.create! params.require(:category).permit(:name)
  rescue ActiveRecord::RecordInvalid => e
    render json: {messages: e.as_json}, status: :unprocessable_entity
  end
end
