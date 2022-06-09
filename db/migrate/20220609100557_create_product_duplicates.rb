class CreateProductDuplicates < ActiveRecord::Migration[7.0]
  def change
    create_table :product_duplicates do |t|
      t.references :product, null: false, foreign_key: true
      t.integer :canonical_product_id
      t.string :action
      t.decimal :certainty_percentage, precision: 8, scale: 2
      t.integer :mapped_product_id
      t.decimal :levenshtein_distance, precision: 8, scale: 2
      t.decimal :similarity_score, precision: 8, scale: 2

      t.timestamps
    end
  end
end
