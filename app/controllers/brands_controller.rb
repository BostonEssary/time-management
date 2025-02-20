class BrandsController < ApplicationController
  include Searchable

  searchable_model Brand

  def show
    @brand = Brand.find(params[:id])
  end
end
