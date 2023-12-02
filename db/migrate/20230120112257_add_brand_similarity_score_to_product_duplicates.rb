class AddBrandSimilarityScoreToProductDuplicates < ActiveRecord::Migration[7.0]
  def change
    rename_column :product_duplicates, :similarity_score, :item_description_similarity_score
    rename_column :product_duplicates, :levenshtein_distance, :item_description_levenshtein_distance
    rename_column :product_duplicates, :canonical_product_id, :potential_duplicate_product_id
    add_column :product_duplicates, :brand_similarity_score, :decimal, precision: 8, scale: 2
    change_column :product_duplicates, :certainty_percentage, :decimal, precision: 10, scale: 4
  end
end
