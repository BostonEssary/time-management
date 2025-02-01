class CreateConcentrates < ActiveRecord::Migration[7.2]
  def change
    create_table :concentrates do |t|
      t.string :strain
      t.string :concentrate_type
      t.references :brand, null: false, foreign_key: true
      t.string :name
      t.float :thc

      t.timestamps
    end
  end
end
