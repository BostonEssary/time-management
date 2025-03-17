class AuthenticatedController < ApplicationController
  before_action :authenticate_user

  private

  def authenticate_user
    if current_user.nil?
      respond_to do |format|
        format.html {
          render turbo_stream: turbo_stream.append("modal", partial: "shared/login_modal"), status: :unauthorized
        }
        format.turbo_stream {
          render turbo_stream: turbo_stream.append("modal", partial: "shared/login_modal"), status: :unauthorized
        }
      end
    end
  end
end
