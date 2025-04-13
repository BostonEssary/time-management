class AddEmbeddingToFlowers < ActiveRecord::Migration[7.2]
  def change
    add_column :flowers, :embedding, :vector
  end
end
