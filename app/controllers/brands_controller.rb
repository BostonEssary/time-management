class BrandsController < ApplicationController
  include Searchable

  searchable_model Brand

  def new
    @brand = Brand.new
  end

  def create
    @brand = Brand.new(brand_params)
    if @brand.save
      redirect_to brand_path(@brand), notice: "Brand created successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @brand = Brand.find(params[:id])
  end

  private

  def brand_params
    params.require(:brand).permit(:name, :avatar)
  end
end
