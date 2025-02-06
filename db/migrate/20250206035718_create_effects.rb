class CreateEffects < ActiveRecord::Migration[7.2]
  def change
    create_table :effects do |t|
      t.text :description
      t.string :name, null: false

      t.timestamps
    end
    
    add_index :effects, :name, unique: true
  end
end
