class AddCounterCaches < ActiveRecord::Migration[7.0]
  def change
    add_column :brands, :brand_aliases_count, :integer, null: false, default: 0
    add_column :dictionary_entries, :abbreviations_count, :integer, null: false, default: 0
    add_column :item_measures, :item_measure_aliases_count, :integer, null: false, default: 0
    add_column :item_packs, :item_pack_aliases_count, :integer, null: false, default: 0
    add_column :item_sell_packs, :item_sell_pack_aliases_count, :integer, null: false, default: 0
    add_column :products, :product_duplicates_count, :integer, null: false, default: 0
    add_column :products, :product_issues_count, :integer, null: false, default: 0
    add_column :products, :product_issues_outstanding_count, :integer, null: false, default: 0
    add_column :products, :product_translations_count, :integer, null: false, default: 0
  end
end
