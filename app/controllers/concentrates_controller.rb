class ConcentratesController < ApplicationController
  include Ratable

  layout "product", only: [ :show ]
  before_action :set_concentrate, only: [ :show ]

  def index
    @concentrates = fetch_filtered_concentrates
    @last_reviews = Concentrate.fetch_last_reviews(@concentrates)
  end

  def create
    @concentrate = Concentrate.new(concentrate_params)
    if @concentrate.save
      redirect_to concentrate_path(@concentrate), notice: "Concentrate created"
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
    @concentrate = Concentrate.new
  end

  def delete
  end

  private

  def fetch_filtered_concentrates
    Concentrate.with_ratings_and_score
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
         .filter_by_category(params[:category])
  end

  def apply_sorting(scope)
    scope.sort_by_param(params[:sort])
  end

  def concentrate_params
    params.require(:concentrate).permit(:name, :thc, :strain, :category, :brand_id, :avatar, images: [])
  end

  def set_concentrate
    @concentrate = Concentrate.find_by(id: params[:id])
    redirect_to root_path, alert: "Concentrate could not be found" unless @concentrate.present?
  end
end
