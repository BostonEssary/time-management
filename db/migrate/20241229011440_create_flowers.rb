class CreateFlowers < ActiveRecord::Migration[7.2]
  def change
    create_table :flowers do |t|
      t.references :brand, null: false, foreign_key: true
      t.string :name
      t.float :thc
      t.string :strain

      t.timestamps
    end

    add_index :flowers, [ :name, :brand_id ], unique: true
  end
end
