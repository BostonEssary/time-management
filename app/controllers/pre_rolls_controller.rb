class PreRollsController < ApplicationController
  include Ratable

  layout "product", only: [ :show ]
  before_action :set_pre_roll, only: [ :show ]

  def index
    @pre_rolls = PreRoll.includes(ratings: :user)
                       .select("pre_rolls.*, COUNT(ratings.id) as ratings_count, AVG(ratings.score) as average_score")
                       .left_joins(:ratings)
                       .group("pre_rolls.id")
                       .page(params[:page])
                       .per(6)

    # Get the last review for each pre_roll
    last_reviews = Rating.select("DISTINCT ON (ratable_id) *")
                        .where(ratable_type: "PreRoll", ratable_id: @pre_rolls.map(&:id))
                        .order("ratable_id, created_at DESC")
                        .includes(:user)

    # Create a hash of pre_roll_id => last_review
    @last_reviews = last_reviews.index_by(&:ratable_id)
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

  def pre_roll_params
    params.require(:pre_roll).permit(:name, :thc, :strain, :infused, :brand_id, :avatar, images: [])
  end

  def set_pre_roll
    @pre_roll = PreRoll.find_by(id: params[:id])
    redirect_to root_path, alert: "Pre-roll could not be found" unless @pre_roll.present?
  end
end
