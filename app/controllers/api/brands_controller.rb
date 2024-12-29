class Api::BrandsController < ApplicationController
  def index
    @brands = if params[:query].present?
      Brand.where("name ILIKE ?", "%#{params[:query]}%")
    else
      Brand.all
    end
  end
end
