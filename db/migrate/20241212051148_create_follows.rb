class CreateFollows < ActiveRecord::Migration[7.2]
  def change
    create_table :follows do |t|
      t.timestamps
      t.belongs_to :followee, foreign_key: { to_table: :users }
      t.belongs_to :follower, foreign_key: { to_table: :users }
    end

    add_index :follows, [:followee_id, :follower_id], unique: true
  end
end
