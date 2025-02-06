# == Schema Information
#
# Table name: product_effects
#
#  id              :bigint           not null, primary key
#  effectable_type :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  effect_id       :bigint           not null
#  effectable_id   :bigint           not null
#
# Indexes
#
#  index_product_effects_on_effect_id   (effect_id)
#  index_product_effects_on_effectable  (effectable_type,effectable_id)
#  index_product_effects_uniqueness     (effect_id,effectable_type,effectable_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (effect_id => effects.id)
#
class ProductEffect < ApplicationRecord
  belongs_to :effect
  belongs_to :effectable, polymorphic: true

  validates :effect_id, uniqueness: { scope: [ :effectable_type, :effectable_id ],
                                    message: "has already been added to this product" }
end
