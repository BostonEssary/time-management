class FollowsController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    @follow = Follow.new(follower_id: current_user.id, followee_id: params[:user_id])

    if @follow.save
      redirect_to user_path(params[:user_id]), notice: "You are now following #{@user.username}"
    else
      render "user/show"
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
end
