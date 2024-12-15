class UsersController < ApplicationController
  before_action :following, only: [:show]

  def show
    @user = User.find(params[:id])
  end


  private

  def following 
    @following = Follow.find_by(follower_id: current_user.id, followee_id: params[:id])
  end

end
