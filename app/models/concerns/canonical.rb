# frozen_string_literal: true

module Canonical
  extend ActiveSupport::Concern

  private

  def canonical_red_flag_penalties
    [
      (0.15 if product_issues_outstanding_count.positive?),
      (0.15 if image_file_name.nil?),
      (0.15 if insufficient_catalogue_usage?),
      (0.15 if insufficient_transaction_usage?),
      (0.15 if insufficient_settings_usage?),
      (0.15 if insufficient_prices?)
    ].compact.sum || 0
  end

  def insufficient_catalogue_usage?
    (catalogue_usage_count || 0) < likely_duplicates_average(facet: :catalogue_usage_count)
  end

  def insufficient_transaction_usage?
    (transaction_usage_count || 0) < likely_duplicates_average(facet: :transaction_usage_count)
  end

  def insufficient_settings_usage?
    (settings_usage_count || 0) < likely_duplicates_average(facet: :settings_usage_count)
  end

  def insufficient_prices?
    (price_count || 0) < likely_duplicates_average(facet: :price_count)
  end

  def likely_duplicates_average(facet:)
    return 0 if product_duplicates.most_likely.size.zero?

    product_duplicates.most_likely.map(&facet).compact.reduce(0, :+) / product_duplicates.most_likely.size
  end
end
