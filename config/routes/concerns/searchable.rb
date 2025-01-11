module Searchable
  extend ActiveSupport::Concern

  included do
    collection do
      get :search
    end
  end
end
