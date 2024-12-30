class FlowersController < ApplicationController
  def index
  end

  def create
    if Flower.create(flower_params)
      redirect_to root_path, notice: 'Flower created'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def update
  end

  def edit
  end

  def new
    @flower = Flower.new
  end

  def delete
  end

  private

  def flower_params
    params.require(:flower).permit(:name, :thc, :strain, :brand_id)
  end
end
