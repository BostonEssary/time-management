class PreRollsController < ApplicationController
  include Ratable

  layout "product", only: [ :show ]
  before_action :set_pre_roll, only: [ :show ]

  def index
    @pre_rolls = fetch_filtered_pre_rolls
    @last_reviews = PreRoll.fetch_last_reviews(@pre_rolls)
  end

  def create
    @pre_roll = PreRoll.new(pre_roll_params)
    if @pre_roll.save
      redirect_to pre_roll_path(@pre_roll), notice: "Pre-roll created"
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
    @pre_roll = PreRoll.new
  end

  def delete
  end

  private

  def fetch_filtered_pre_rolls
    PreRoll.with_ratings_and_score
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
         .filter_by_infused(params[:infused])
  end

  def apply_sorting(scope)
    scope.sort_by_param(params[:sort])
  end

  def pre_roll_params
    params.require(:pre_roll).permit(:name, :thc, :strain, :infused, :brand_id, :avatar, images: [], effect_ids: [])
  end

  def set_pre_roll
    @pre_roll = PreRoll.find_by(id: params[:id])
    redirect_to root_path, alert: "Pre-roll could not be found" unless @pre_roll.present?
  end
end
