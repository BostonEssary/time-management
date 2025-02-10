class AddCommentToRatings < ActiveRecord::Migration[7.2]
  def change
    add_column :ratings, :comment, :text
  end
end
