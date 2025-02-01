class CreateEdibles < ActiveRecord::Migration[7.2]
  def change
    create_table :edibles do |t|
      t.string :name
      t.string :strain
      t.integer :mg_per_serving
      t.references :brand, null: false, foreign_key: true
      t.string :food_type

      t.timestamps
    end
  end
end
