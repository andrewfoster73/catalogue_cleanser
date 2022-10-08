class CreateProductTranslations < ActiveRecord::Migration[7.0]
  def change
    create_table :product_translations do |t|
      t.references :product
      t.string :locale
      t.text :item_description
      t.string :brand
      t.numeric :item_size, precision: 19, scale: 4
      t.string :item_measure
      t.string :item_pack_name
      t.numeric :item_sell_quantity, precision: 19, scale: 4
      t.string :item_sell_pack_name
      t.boolean :valid_locale, null: false, default: false
      t.boolean :valid_translations, null: false, default: false
      t.timestamps
    end
  end
end
