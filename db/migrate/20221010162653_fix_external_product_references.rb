class FixExternalProductReferences < ActiveRecord::Migration[7.0]
  def change
    rename_column :products, :product_id, :external_product_id
    add_reference :product_translations, :external_product_translation
  end
end
