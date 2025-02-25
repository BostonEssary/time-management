class DashboardController < ApplicationController
  def show
    @ratings = Rating.includes(:user, :ratable, :likes, image_attachment: :blob)
                    .where(user: current_user.followees)
                    .order(created_at: :desc)
                    .page(params[:page])
                    .per(5)
  end
end
