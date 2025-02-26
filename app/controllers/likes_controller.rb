class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_likeable

  def create
    @like = @likeable.likes.build(user: current_user)
    @like.save
  end

  def destroy
    @like = @likeable.likes.find_by(user: current_user)
    @like&.destroy
  end

  private

  def set_likeable
    if params[:rating_id]
      @likeable = Rating.find(params[:rating_id])
    else
      # Add other likeable types here as needed
      head :not_found
    end
  end
end
