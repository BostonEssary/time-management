class CreateFlowers < ActiveRecord::Migration[7.2]
  def change
    create_table :flowers do |t|
      t.references :brands, null: false, foreign_key: true
      t.string :name
      t.float :thc
      t.string :strain

      t.timestamps
    end
  end
end
