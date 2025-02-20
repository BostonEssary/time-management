module SearchScope
  extend ActiveSupport::Concern

  included do
    # Define which attributes should be searchable in your model
    class_attribute :searchable_attributes, default: []
  end

  class_methods do
    def search_by(*attributes)
      self.searchable_attributes = attributes
    end

    def search_by_term(term)
      return none if term.blank?

      conditions = searchable_attributes.map do |attribute|
        arel_table[attribute].matches("%#{sanitize_sql_like(term)}%")
      end

      where(conditions.inject(:or))
    end
  end
end
