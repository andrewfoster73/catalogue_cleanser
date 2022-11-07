class AddSourceToImportableTables < ActiveRecord::Migration[7.0]
  def up
    execute <<-SQL
      CREATE TYPE data_source_type AS ENUM ('import', 'manual');
    SQL

    add_column :products, :data_source, :data_source_type, default: 'manual'
    add_column :product_translations, :data_source, :data_source_type, default: 'manual'
    add_column :item_sell_packs, :data_source, :data_source_type, default: 'manual'
    add_column :item_sell_pack_aliases, :data_source, :data_source_type, default: 'manual'
    add_column :item_measures, :data_source, :data_source_type, default: 'manual'
    add_column :item_measure_aliases, :data_source, :data_source_type, default: 'manual'
    add_column :item_packs, :data_source, :data_source_type, default: 'manual'
    add_column :item_pack_aliases, :data_source, :data_source_type, default: 'manual'
    add_column :brands, :data_source, :data_source_type, default: 'manual'
    add_column :brand_aliases, :data_source, :data_source_type, default: 'manual'
  end

  def down
    execute <<-SQL
      DROP TYPE data_source_type;
    SQL

    remove_column :products, :data_source
    remove_column :product_translations, :data_source
    remove_column :item_sell_packs, :data_source
    remove_column :item_sell_pack_aliases, :data_source
    remove_column :item_measures, :data_source
    remove_column :item_measure_aliases, :data_source
    remove_column :item_packs, :data_source
    remove_column :item_pack_aliases, :data_source
    remove_column :brands, :data_source
    remove_column :brand_aliases, :data_source
  end
end
