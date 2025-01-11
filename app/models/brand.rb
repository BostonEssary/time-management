class Brand < ApplicationRecord
  include SearchScope

  search_by :name
end
