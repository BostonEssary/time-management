class ChangePrefencesToPreferencesOnUser < ActiveRecord::Migration[7.2]
  def change
    rename_column :users, :consumption_prefences, :consumption_preferences
  end
end
