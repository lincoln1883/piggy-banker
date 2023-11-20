class CategoriesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  def index
    @categories = Category.includes(:user, :expenditure).all
  end

  def new
    @category = Category.new
  end

  def create
    @category = current_user.categories.build(category_params)
    if @category.save
      redirect_to categories_path, notice: 'Category created successfully!'
    else
      flash[:alert] = 'Category could not be saved validation errors'
      render :new
    end
  end

  def destroy
    @category = Category.find(params[:id])
    if @category.destroy
      redirect_to categories_path, notice: 'Category deleted successfully!'
    else
      flash[:alert] = 'Category could not be deleted'
      render :index
    end
  end

  private

  def category_params
    params.require(:category).permit(:name, :icon, :author_id)
  end
end
