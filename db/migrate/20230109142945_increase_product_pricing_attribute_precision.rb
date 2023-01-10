class IncreaseProductPricingAttributePrecision < ActiveRecord::Migration[7.0]
  def change
    change_column :products, :average_price, :decimal, precision: 19, scale: 2
    change_column :products, :maximum_price, :decimal, precision: 19, scale: 2
    change_column :products, :minimum_price, :decimal, precision: 19, scale: 2
    change_column :products, :standard_deviation, :decimal, precision: 19, scale: 2
    change_column :products, :median_price, :decimal, precision: 19, scale: 2
  end
end
