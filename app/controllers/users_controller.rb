class UsersController < ApplicationController
  before_action :following, only: [:show]
  before_action :set_user
  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end



  private

  def set_user
    @user = User.find(params[:id])
  end

  def following 
    @following = Follow.find_by(follower_id: current_user.id, followee_id: params[:id])
  end
  
  def user_params
    params.require(:user).permit(:username, :experience_level, { consumption_preferences: [] })
  end
end
