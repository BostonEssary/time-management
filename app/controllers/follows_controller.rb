class FollowsController < ApplicationController
  before_action :set_user
  before_action :set_followee, only: :create

  def create
    @follow = Follow.new(follower_id: current_user.id, followee_id: params[:user_id])

    if @follow.save
      redirect_to user_path(params[:user_id]), notice: "You are now following #{@followee.username}"
    else
      render "dashboard/index", status: :unprocessable_entity
    end
  end

  def destroy
    @follow = Follow.find(params[:id])
    @user = @follow.followee
    if @follow.destroy
      redirect_to user_path(@user), notice: "You unfollowed #{ @user.username}"
    else
      render "users/show"
    end
  end

  private

  def set_user
    @user = current_user
  end

  def set_followee
    @followee = User.find_by(id: follow_params[:user_id])

    if @followee.nil?
      flash[:alert] = "User not found"
      render "profiles/show", status: :unprocessable_entity
    end
  end

  def follow_params
    params.permit(:user_id)
  end
end
