class AddDescriptionToFlower < ActiveRecord::Migration[7.2]
  def change
    add_column :flowers, :description, :text
  end
end
