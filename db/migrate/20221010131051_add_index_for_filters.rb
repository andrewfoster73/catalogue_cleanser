class AddIndexForFilters < ActiveRecord::Migration[7.0]
  def up
    execute <<-SQL
      CREATE EXTENSION pg_trgm;
      CREATE INDEX index_products_item_description_gin ON products USING gin (item_description gin_trgm_ops);
    SQL
    add_index :item_sell_packs, :canonical
    add_index :item_sell_pack_aliases, :confirmed
    add_index :audits, :action
  end

  def down
    remove_index :index_products_item_description_gin
    remove_index :item_sell_packs, :canonical
    remove_index :item_sell_pack_aliases, :confirmed
    remove_index :audits, :action
    execute <<-SQL
      DROP EXTENSION pg_trgm;
    SQL
  end
end
