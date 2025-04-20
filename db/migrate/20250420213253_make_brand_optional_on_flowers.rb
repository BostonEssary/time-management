class MakeBrandOptionalOnFlowers < ActiveRecord::Migration[7.2]
  def change
    change_column_null :flowers, :brand_id, true
  end
end
