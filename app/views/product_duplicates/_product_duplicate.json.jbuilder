# frozen_string_literal: true

json.extract!(product_duplicate, :id, :product_id, :potential_duplicate_product_id, :action, :certainty_percentage,
              :mapped_product_id, :item_description_levenshtein_distance, :item_description_similarity_score,
              :created_at, :updated_at
)
json.url(product_duplicate_url(product_duplicate, format: :json))
