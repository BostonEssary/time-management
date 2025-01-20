class FlowersController < ApplicationController
  before_action :set_flower, only: [ :show ]

  def index
  end

  def create
    @flower = Flower.new(flower_params)
    if @flower.save
      redirect_to flower_path(@flower), notice: 'Flower created'
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
    params.require(:flower).permit(:name, :thc, :strain, :brand_id, :avatar, images: [])
  end

  def set_flower
    @flower = Flower.find_by(id: params[:id])
    redirect_to root_path, alert: "Flower could not be found" unless @flower.present?
  end
end
