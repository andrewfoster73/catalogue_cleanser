# frozen_string_literal: true

class ProductDuplicatesController < ResourcesController
  private

  # Only allow a list of trusted parameters through.
  def permitted_params
    %i[
      product_id canonical_product_id action certainty_percentage mapped_product_id levenshtein_distance
      similarity_score
    ]
  end
end
