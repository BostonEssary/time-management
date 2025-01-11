module Searchable
  extend ActiveSupport::Concern

  included do
    class_attribute :search_model
  end

  class_methods do
    def searchable_model(model)
      self.search_model = model
    end
  end

  def search
    query = params[:q].to_s.strip
    @results = if query.present?
      search_model.search_by_term(query)
    else
      search_model.none
    end

    render partial: "shared/search_results",
           locals: { results: @results, model_name: search_model.model_name.human }
  end
end
