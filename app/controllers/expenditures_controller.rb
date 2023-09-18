class ExpendituresController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  def index
    @category = Category.includes(:user, :expenditure).find(params[:category_id])
    @expenditures = @category.expenditure.order(created_at: :desc).limit(3)
  end

  def new
    @category = Category.find(params[:category_id])
    @expenditure = Expenditure.new
  end

  def create
    @category = Category.find(params[:category_id])
    @expenditure = @category.expenditure.new(expenditure_params)
    @expenditure.user_id = current_user.id

    if @expenditure.save
      redirect_to categories_path, notice: 'Expenditure created successfully.'
    else
      flash[:alert] = 'Expenditure could not be saved validation errors.'
      render 'new'
    end
  end

  def destroy
    @category = Category.find(params[:category_id])
    @expenditure = @category.expenditure.find(params[:id])
    @expenditure.destroy
  end

  private

  def expenditure_params
    params.require(:expenditure).permit(:name, :amount, :category_id, :user_id)
  end
end
