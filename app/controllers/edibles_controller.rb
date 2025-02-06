class EdiblesController < ApplicationController
  before_action :set_edible, only: [ :show ]

  def index
    @edibles = Edible.all
  end

  def create
    @edible = Edible.new(edible_params)
    if @edible.save
      redirect_to edible_path(@edible), notice: "Edible created"
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
    @edible = Edible.new
  end

  def delete
  end

  private

  def edible_params
    params.require(:edible).permit(:name, :thc, :brand_id, :category, :avatar, images: [])
  end

  def set_edible
    @edible = Edible.find_by(id: params[:id])
    redirect_to root_path, alert: "Edible could not be found" unless @edible.present?
  end
end
