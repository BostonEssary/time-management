class EdiblesController < ApplicationController
  include Ratable

  layout "product", only: [ :show ]
  before_action :set_edible, only: [ :show ]

  def index
    @edibles = fetch_filtered_edibles
    @last_reviews = Edible.fetch_last_reviews(@edibles)
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

  def fetch_filtered_edibles
    Edible.with_ratings_and_score
          .then { |scope| apply_search(scope) }
          .then { |scope| apply_filters(scope) }
          .then { |scope| apply_sorting(scope) }
          .page(params[:page])
          .per(6)
  end

  def apply_search(scope)
    scope.search_by_term(params[:query])
  end

  def apply_filters(scope)
    scope.filter_by_strain(params[:filter])
         .filter_by_food_type(params[:food_type])
  end

  def apply_sorting(scope)
    scope.sort_by_param(params[:sort])
  end

  def edible_params
    params.require(:edible).permit(:name, :mg_per_serving, :strain, :food_type, :brand_id, :avatar, images: [])
  end

  def set_edible
    @edible = Edible.find_by(id: params[:id])
    redirect_to root_path, alert: "Edible could not be found" unless @edible.present?
  end
end
