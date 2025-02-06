class RenameConcentrationTypeToCategoryOnConcentrates < ActiveRecord::Migration[7.2]
  def change
    rename_column :concentrates, :concentrate_type, :category
  end
end
