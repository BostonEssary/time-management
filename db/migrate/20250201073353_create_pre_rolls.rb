class CreatePreRolls < ActiveRecord::Migration[7.2]
  def change
    create_table :pre_rolls do |t|
      t.string :name
      t.string :strain
      t.string :thc
      t.references :brand, null: false, foreign_key: true
      t.boolean :infused

      t.timestamps
    end
  end
end
