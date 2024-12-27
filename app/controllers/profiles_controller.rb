class ProfilesController < ApplicationController
  before_action :set_user
  def show
  end

  def edit
  end

  def update
    return head :forbidden unless @user == current_user

    if @user.update(user_params)
      redirect_to profile_path, notice: "Profile updated successfully!"
    else
      render "profiles/edit", status: :unprocessable_entity
    end
  end


  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:username, :experience_level, { consumption_preferences: [] })
  end
end
