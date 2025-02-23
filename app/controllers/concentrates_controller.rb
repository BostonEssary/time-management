class ConcentratesController < ApplicationController
  layout "product", only: [ :show ]
  before_action :set_concentrate, only: [ :show ]

  def index
    @concentrates = Concentrate.includes(ratings: :user)
                             .select("concentrates.*, COUNT(ratings.id) as ratings_count, AVG(ratings.score) as average_score")
                             .left_joins(:ratings)
                             .group("concentrates.id")
                             .page(params[:page])
                             .per(6)

    # Get the last review for each concentrate
    last_reviews = Rating.select("DISTINCT ON (ratable_id) *")
                        .where(ratable_type: "Concentrate", ratable_id: @concentrates.map(&:id))
                        .order("ratable_id, created_at DESC")
                        .includes(:user)

    # Create a hash of concentrate_id => last_review
    @last_reviews = last_reviews.index_by(&:ratable_id)
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

  def concentrate_params
    params.require(:concentrate).permit(:name, :thc, :strain, :category, :brand_id, :avatar, images: [])
  end

  def set_concentrate
    @concentrate = Concentrate.find_by(id: params[:id])
    redirect_to root_path, alert: "Concentrate could not be found" unless @concentrate.present?
  end
end
