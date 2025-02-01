# == Schema Information
#
# Table name: edibles
#
#  id             :bigint           not null, primary key
#  food_type      :string
#  mg_per_serving :integer
#  name           :string
#  strain         :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  brand_id       :bigint           not null
#
# Indexes
#
#  index_edibles_on_brand_id  (brand_id)
#
# Foreign Keys
#
#  fk_rails_...  (brand_id => brands.id)
#
require 'rails_helper'

RSpec.describe Edible, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
