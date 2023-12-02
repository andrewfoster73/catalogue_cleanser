# frozen_string_literal: true

class ProductDuplicate < ApplicationRecord
  include Broadcast
  include NestedBroadcast

  MINIMUM_CERTAINTY_PERCENTAGE = 0.9
  public_constant :MINIMUM_CERTAINTY_PERCENTAGE

  belongs_to :product, inverse_of: :product_duplicates, counter_cache: true
  belongs_to :potential_duplicate_product, class_name: 'Product', inverse_of: :potential_duplicates
  belongs_to :mapped_product, class_name: 'Product', inverse_of: :mapped_products, optional: true

  audited associated_with: :product

  scope :most_likely, -> { where('certainty_percentage >= ?', MINIMUM_CERTAINTY_PERCENTAGE) }

  delegate :to_s, to: :product
  delegate :item_description, :brand, :item_size, :item_measure, :item_pack_name, :item_sell_quantity,
           :item_sell_pack_name, :category, :external_product_id, :catalogue_usage_count,
           :transaction_usage_count, :settings_usage_count, :price_count, to: :potential_duplicate_product

  def self.ransackable_attributes(auth_object = nil)
    %w[action brand_similarity_score certainty_percentage created_at id item_description_levenshtein_distance item_description_similarity_score mapped_product_id potential_duplicate_product_id product_id updated_at]
  end

  def calculate_certainty_percentage(possible_dup:)
    certainty_facets(possible_dup: possible_dup).values.sum
  end

  def certainty_facets(possible_dup:)
    {
      description:
        weighted_value(value: possible_dup.item_description_similarity || 0, weight: 0.33),
      brand:
        weighted_value(value: possible_dup.brand_similarity || 0, weight: 0.18),
      item_pack_name:
        weighted_value(value: possible_dup.item_pack_name == product.item_pack_name ? 1 : 0, weight: 0.05),
      item_measure:
        weighted_value(value: possible_dup.item_measure == product.item_measure ? 1 : 0, weight: 0.05),
      item_sell_pack_name:
        weighted_value(
          value: possible_dup.item_sell_pack_name == product.item_sell_pack_name ? 1 : 0,
          weight: 0.05
        ),
      median_price:
        weighted_value(
          value: BigDecimal(1) - error_percentage(one: possible_dup.median_price, two: product.median_price),
          weight: 0.06
        ),
      item_size:
        weighted_value(
          value: BigDecimal(1) - error_percentage(one: possible_dup.item_size, two: product.item_size),
          weight: 0.18
        ),
      item_sell_quantity:
        weighted_value(
          value: BigDecimal(1) - error_percentage(one: possible_dup.item_sell_quantity,
                                                  two: product.item_sell_quantity
                                                 ),
          weight: 0.1
        )
    }
  end

  def parent
    product
  end

  private

  def weighted_value(value:, weight:)
    BigDecimal(weight, 2) * BigDecimal(value, 2)
  end

  def error_percentage(one:, two:)
    return BigDecimal(1) if (one || 0).zero?

    error = (BigDecimal(one || 0) - BigDecimal(two || 0)).abs / BigDecimal(one || 0)
    # If the error is so large it exceeds 100% then just return 100%
    # This will prevent negative numbers in the certainty_facets
    error > 1 ? BigDecimal(1) : error
  end
end
