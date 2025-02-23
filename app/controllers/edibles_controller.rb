class EdiblesController < ApplicationController
  include Ratable

  layout "product", only: [ :show ]
  before_action :set_edible, only: [ :show ]

  def index
    @edibles = Edible.includes(ratings: :user)
                    .select("edibles.*, COUNT(ratings.id) as ratings_count, AVG(ratings.score) as average_score")
                    .left_joins(:ratings)
                    .group("edibles.id")
                    .page(params[:page])
                    .per(6)

    # Get the last review for each edible
    last_reviews = Rating.select("DISTINCT ON (ratable_id) *")
                        .where(ratable_type: "Edible", ratable_id: @edibles.map(&:id))
                        .order("ratable_id, created_at DESC")
                        .includes(:user)

    # Create a hash of edible_id => last_review
    @last_reviews = last_reviews.index_by(&:ratable_id)
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
    params.require(:edible).permit(:name, :thc, :strain, :mg_per_serving, :food_type, :brand_id, :avatar, images: [])
  end

  def set_edible
    @edible = Edible.find_by(id: params[:id])
    redirect_to root_path, alert: "Edible could not be found" unless @edible.present?
  end
end
