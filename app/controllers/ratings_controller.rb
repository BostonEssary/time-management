class RatingsController < ApplicationController
  before_action :set_ratable, only: [ :new ]

  def create
    @rating = Rating.new(user: current_user, **rating_params)
    @ratable = @rating.ratable
    if @rating.save
      redirect_to @rating.ratable, notice: "Rating created successfully"
    else
      respond_to do |format|
        format.turbo_stream { render :new, status: :unprocessable_entity }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def new
    @rating = Rating.new
  end

  private

  def set_ratable
    @ratable_type = params[:ratable_type]
    @ratable_id = params[:ratable_id]
    @ratable = @ratable_type.classify.constantize.find(@ratable_id)
  end

  def set_ratable_type
    @ratable_type = params[:ratable_type]
  end

  def set_ratable_id
    @ratable_id = params[:ratable_id]
  end

  def rating_params
    params.require(:rating).permit(:score, :comment, :image, :ratable_id, :ratable_type)
  end
end
