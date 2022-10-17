# frozen_string_literal: true

require 'test_helper'

class ProductDuplicateTest < ActiveSupport::TestCase
  test 'to_s' do
    product = build_stubbed(:product, item_description: 'Lager')
    product_duplicate = build_stubbed(:product_duplicate, product: product)
    assert_equal('Lager', product_duplicate.to_s)
  end
end
