class AddCollectionTimestamps < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :collected_certainty_at, :timestamp
  end
end
