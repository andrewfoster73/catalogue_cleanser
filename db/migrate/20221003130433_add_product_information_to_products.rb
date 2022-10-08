class AddProductInformationToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :item_description, :text
    add_column :products, :brand, :string
    add_column :products, :item_size, :numeric, precision: 19, scale: 4
    add_column :products, :item_measure, :string
    add_column :products, :item_pack_name, :string
    add_column :products, :item_sell_quantity, :numeric, precision: 19, scale: 4
    add_column :products, :item_sell_pack_name, :string
    add_column :products, :volume_in_litres, :numeric, precision: 19, scale: 4
    add_reference :products, :category
    add_column :products, :category_path, :text
    add_column :products, :image_file_name, :string
    add_column :products, :image_updated_at, :timestamp
    add_column :products, :last_synced_at, :timestamp
    add_column :products, :locale, :string
    add_column :products, :issues_count, :integer, null: false, default: 0
    add_column :products, :translations_count, :integer, null: false, default: 0
  end
end
