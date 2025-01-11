class Api::BrandsController < ApplicationController
  def index
    @brands = if params[:q].present?
      Brand.where("name ILIKE ?", "%#{params[:q]}%")
    else
      Brand.all
    end
  end
end
