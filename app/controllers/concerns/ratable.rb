module Ratable
  extend ActiveSupport::Concern

  included do
    before_action :set_ratable, only: [ :show ]
  end

  private

  def set_ratable
    model_class = controller_name.classify.constantize
    @ratable = model_class.find_by(id: params[:id])
    redirect_to root_path, alert: "#{controller_name.humanize.singularize} could not be found" unless @ratable.present?
  end
end
