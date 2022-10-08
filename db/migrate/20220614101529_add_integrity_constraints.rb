class AddIntegrityConstraints < ActiveRecord::Migration[7.0]
  def change
    change_column_null :abbreviations, :letters, false
    change_column_null :brands, :name, false
    change_column_null :brand_aliases, :alias, false
    change_column_null :comments, :message, false
    change_column_null :dictionary_entries, :phrase, false
    change_column_null :item_measures, :name, false
    change_column_null :item_measure_aliases, :alias, false
    change_column_null :item_packs, :name, false
    change_column_null :item_pack_aliases, :alias, false
    change_column_null :item_sell_packs, :name, false
    change_column_null :item_sell_pack_aliases, :alias, false
    change_column_null :products, :product_id, false
    add_check_constraint :products, 'buy_list_count >= 0', name: 'buy_list_count_check'
    add_check_constraint :products, 'catalogue_count >= 0', name: 'catalogue_count_check'
    add_check_constraint :products, 'inventory_barcodes_count >= 0', name: 'inventory_barcodes_count_check'
    add_check_constraint :products, 'inventory_derived_period_balances_count >= 0', name: 'inventory_derived_period_balances_count_check'
    add_check_constraint :products, 'inventory_internal_requisition_lines_count >= 0', name: 'inventory_internal_requisition_lines_count_check'
    add_check_constraint :products, 'inventory_stock_counts_count >= 0', name: 'inventory_stock_counts_count_check'
    add_check_constraint :products, 'inventory_stock_levels_count >= 0', name: 'inventory_stock_levels_count_check'
    add_check_constraint :products, 'inventory_transfer_items_count >= 0', name: 'inventory_transfer_items_count_check'
    add_check_constraint :products, 'invoice_line_items_count >= 0', name: 'invoice_line_items_count_check'
    add_check_constraint :products, 'point_of_sale_lines_count >= 0', name: 'point_of_sale_lines_count_check'
    add_check_constraint :products, 'procurement_products_count >= 0', name: 'procurement_products_count_check'
    add_check_constraint :products, 'product_supplier_preferences_count >= 0', name: 'product_supplier_preferences_count_check'
    add_check_constraint :products, 'purchase_order_line_items_count >= 0', name: 'purchase_order_line_items_count_check'
    add_check_constraint :products, 'rebates_profile_products_count >= 0', name: 'rebates_profile_products_count_check'
    add_check_constraint :products, 'receiving_document_line_items_count >= 0', name: 'receiving_document_line_items_count_check'
    add_check_constraint :products, 'recipes_count >= 0', name: 'recipes_count_check'
    add_check_constraint :products, 'requisition_line_items_count >= 0', name: 'requisition_line_items_count_check'
    add_check_constraint :products, 'duplication_certainty >= 0', name: 'duplication_certainty_check'
    add_check_constraint :products, 'canonical_certainty >= 0', name: 'canonical_certainty_check'
    add_check_constraint :products, 'average_price >= 0', name: 'average_price_check'
    add_check_constraint :products, 'maximum_price >= 0', name: 'maximum_price_check'
    add_check_constraint :products, 'minimum_price >= 0', name: 'minimum_price_check'
    add_check_constraint :products, 'standard_deviation >= 0', name: 'standard_deviation_check'
    add_check_constraint :products, 'variance >= 0', name: 'variance_check'

    add_index :abbreviations, :letters, unique: true
    add_index :brands, :name, unique: true
    add_index :brand_aliases, :alias, unique: true
    add_index :dictionary_entries, :phrase, unique: true
    add_index :item_measures, :name, unique: true
    add_index :item_measure_aliases, :alias, unique: true
    add_index :item_packs, :name, unique: true
    add_index :item_pack_aliases, :alias, unique: true
    add_index :item_sell_packs, :name, unique: true
    add_index :item_sell_pack_aliases, :alias, unique: true
    add_index :products, :product_id, unique: true
  end
end
