class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user, unless: :devise_controller?



  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :date_of_birth, :username, :avatar ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :avatar ])
  end

  def authenticate_user
    redirect_to new_user_session_path if current_user.nil?
  end
end
