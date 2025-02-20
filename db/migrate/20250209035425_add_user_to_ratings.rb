class AddUserToRatings < ActiveRecord::Migration[7.2]
  def up
    add_reference :ratings, :user, null: true, foreign_key: true
  end
end
