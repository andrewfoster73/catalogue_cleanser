# frozen_string_literal: true

json.extract!(product_duplicate, :id, :product_id, :canonical_product_id, :action, :certainty_percentage,
              :mapped_product_id, :levenshtein_distance, :similarity_score, :created_at, :updated_at
)
json.url(product_duplicate_url(product_duplicate, format: :json))
