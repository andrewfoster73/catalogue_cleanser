class CleanUpProductsTable < ActiveRecord::Migration[7.0]
  def change
    rename_column :products, :collected_statistics_at, :collected_usage_at
    add_column :products, :collected_pricing_at, :timestamp
    remove_column :products, :variance, :numeric, precision: 8, scale: 2
    add_column :products, :median_price, :numeric, precision: 8, scale: 2
    add_column :products, :price_count, :integer
    add_column :products, :price_country, :string
    add_check_constraint :products, 'price_count >= 0', name: 'price_count_check'
    add_check_constraint :products, 'median_price >= 0', name: 'median_price_check'
  end
end
