# == Schema Information
#
# Table name: ratings
#
#  id           :bigint           not null, primary key
#  comment      :text
#  ratable_type :string           not null
#  score        :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  ratable_id   :bigint           not null
#  user_id      :bigint
#
# Indexes
#
#  index_ratings_on_ratable  (ratable_type,ratable_id)
#  index_ratings_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Rating, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
