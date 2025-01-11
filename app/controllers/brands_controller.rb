class BrandsController < ApplicationController
  include Searchable

  searchable_model Brand
end
