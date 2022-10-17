# frozen_string_literal: true

require 'test_helper'

class ProductTranslationTest < ActiveSupport::TestCase
  test 'supported locale values' do
    assert_equal(%w[en th zh], ProductTranslation.supported_locales_alpha2s)
  end

  test 'parent' do
    product = build_stubbed(:product)
    product_translation = build_stubbed(:product_translation, product: product)
    assert_equal(product, product_translation.parent)
  end

  test 'to_s' do
    product_translation = build_stubbed(:product_translation, item_description: 'Lager', locale: 'en')
    assert_equal('Lager (en)', product_translation.to_s)
  end
end
