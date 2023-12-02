# frozen_string_literal: true

require 'test_helper'

class PotentialProductDuplicatesTest < ActiveSupport::TestCase
  setup do
    @potential_duplicate = create(:product, item_description: 'lger', brand: 'Innis Gunn')
  end

  test 'returns potential duplicates with similarity scores included' do
    results = Queries::PotentialProductDuplicates.call(options: { product: products(:lager) })
    assert_equal(1, results.size)
    result = results.take
    assert_equal(0.375, result.item_description_similarity)
    assert_equal(1, result.item_description_levenshtein)
    assert_equal(1.0, result.brand_similarity)
    assert_equal(@potential_duplicate.id, result.id)
  end
end
