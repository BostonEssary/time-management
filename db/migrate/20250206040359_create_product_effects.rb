class CreateProductEffects < ActiveRecord::Migration[7.2]
  def change
    create_table :product_effects do |t|
      t.references :effect, null: false, foreign_key: true
      t.references :effectable, polymorphic: true, null: false
      t.timestamps
    end
    
    add_index :product_effects, [:effect_id, :effectable_type, :effectable_id], 
              unique: true, 
              name: 'index_product_effects_uniqueness'
  end
end
