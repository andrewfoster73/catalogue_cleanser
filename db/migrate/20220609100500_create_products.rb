class CreateProducts < ActiveRecord::Migration[7.0]
  def up
    execute <<-SQL
      CREATE TYPE product_action AS ENUM ('delete', 'map', 'none', 'pending');
    SQL
    create_table :products do |t|
      t.integer :product_id
      t.decimal :duplication_certainty, precision: 8, scale: 2
      t.decimal :canonical_certainty, precision: 8, scale: 2
      t.boolean :canonical, default: false
      t.timestamp :collected_statistics_at
      t.integer :catalogue_count
      t.integer :buy_list_count
      t.integer :priced_catalogue_count
      t.decimal :average_price, precision: 8, scale: 2
      t.decimal :maximum_price, precision: 8, scale: 2
      t.decimal :minimum_price, precision: 8, scale: 2
      t.decimal :standard_deviation, precision: 8, scale: 2
      t.decimal :variance, precision: 8, scale: 2
      t.integer :inventory_barcodes_count
      t.integer :inventory_derived_period_balances_count
      t.integer :inventory_internal_requisition_lines_count
      t.integer :inventory_stock_counts_count
      t.integer :inventory_stock_levels_count
      t.integer :inventory_transfer_items_count
      t.integer :invoice_line_items_count
      t.integer :point_of_sale_lines_count
      t.integer :procurement_products_count
      t.integer :product_supplier_preferences_count
      t.integer :purchase_order_line_items_count
      t.integer :rebates_profile_products_count
      t.integer :receiving_document_line_items_count
      t.integer :recipes_count
      t.integer :requisition_line_items_count

      t.timestamps
    end

    add_column :products, :action, :product_action
  end

  def down
    drop_table :products
  end
end
