class FlowersController < ApplicationController
  include Ratable

  layout "product", only: [ :show ]
  before_action :set_flower, only: [ :show ]

  def index
    @flowers = Flower.includes(ratings: :user)
                    .select("flowers.*, COUNT(ratings.id) as ratings_count, AVG(ratings.score) as average_score")
                    .left_joins(:ratings)
                    .group("flowers.id")

    # Apply search if query present
    if params[:query].present?
      @flowers = @flowers.joins(:brand)
                        .where("flowers.name ILIKE :query OR flowers.strain ILIKE :query OR brands.name ILIKE :query",
                               query: "%#{params[:query]}%")
    end

    # Apply strain filter if present
    if params[:filter].present?
      @flowers = @flowers.where("LOWER(strain) = ?", params[:filter].downcase)
    end

    # Apply sorting
    @flowers = case params[:sort]
    when "name_asc"
      @flowers.order("flowers.name ASC")
    when "name_desc"
      @flowers.order("flowers.name DESC")
    when "thc_desc"
      @flowers.order("flowers.thc DESC NULLS LAST")
    when "thc_asc"
      @flowers.order("flowers.thc ASC NULLS LAST")
    when "rating_desc"
      @flowers.order("AVG(ratings.score) DESC NULLS LAST")
    when "rating_asc"
      @flowers.order("AVG(ratings.score) ASC NULLS LAST")
    else
      @flowers.order("flowers.created_at DESC") # Default sort
    end

    @flowers = @flowers.page(params[:page]).per(6)

    puts "flowers: #{@flowers.size}"


    # Get the last review for each flower
    last_reviews = Rating.select("DISTINCT ON (ratable_id) *")
                        .where(ratable_type: "Flower", ratable_id: @flowers.map(&:id))
                        .order("ratable_id, created_at DESC")
                        .includes(:user)

    # Create a hash of flower_id => last_review
    @last_reviews = last_reviews.index_by(&:ratable_id)
  end

  def create
    @flower = Flower.new(flower_params)
    if @flower.save
      redirect_to flower_path(@flower), notice: "Flower created"
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
    @flower = Flower.new
  end

  def delete
  end

  private

  def flower_params
    params.require(:flower).permit(:name, :thc, :strain, :brand_id, :avatar, images: [], effect_ids: [])
  end

  def set_flower
    @flower = Flower.find_by(id: params[:id])
    redirect_to root_path, alert: "Flower could not be found" unless @flower.present?
  end
end
