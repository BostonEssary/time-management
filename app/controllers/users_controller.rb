class UsersController < ApplicationController
  before_action :following, only: [ :show ]
  before_action :set_user

  def show; end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def following
    @following = Follow.find_by(follower_id: current_user.id, followee_id: params[:id])
  end
end
