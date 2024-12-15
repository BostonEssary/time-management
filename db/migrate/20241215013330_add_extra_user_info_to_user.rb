class AddExtraUserInfoToUser < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :experience_level, :string
    add_column :users, :consumption_prefences, :string, array: true, default: []
  end
end
