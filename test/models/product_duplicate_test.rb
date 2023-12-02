# frozen_string_literal: true

require 'test_helper'

class ProductDuplicateTest < ActiveSupport::TestCase
  test 'to_s' do
    product = build_stubbed(:product, item_description: 'Lager')
    product_duplicate = build_stubbed(:product_duplicate, product: product)
    assert_equal('Lager', product_duplicate.to_s)
  end

  test 'parent' do
    product = build_stubbed(:product)
    issue = ProductDuplicate.new(product: product)
    assert_equal(product, issue.parent)
  end

  test 'calculate certainty percentage with only item description similarity' do
    product = products(:lager)
    potential_duplicate_product = build_stubbed(
      :product,
      item_description_similarity: 1.0,
      brand_similarity: 0.0,
      item_pack_name: 'fake',
      item_measure: 'fake',
      item_sell_pack_name: 'fake',
      median_price: 0,
      item_size: 0,
      item_sell_quantity: 0
    )
    product_duplicate = build_stubbed(
      :product_duplicate,
      product: product,
      potential_duplicate_product: potential_duplicate_product
    )
    assert_equal(BigDecimal(0.33, 2), product_duplicate.calculate_certainty_percentage(possible_dup: potential_duplicate_product))
  end

  test 'calculate certainty percentage after adding brand similarity' do
    product = products(:lager)
    potential_duplicate_product = build_stubbed(
      :product,
      item_description_similarity: 1.0,
      brand_similarity: 1.0,
      item_pack_name: 'fake',
      item_measure: 'fake',
      item_sell_pack_name: 'fake',
      median_price: 0,
      item_size: 0,
      item_sell_quantity: 0
    )
    product_duplicate = build_stubbed(
      :product_duplicate,
      product: product,
      potential_duplicate_product: potential_duplicate_product
    )
    assert_equal(BigDecimal(0.51, 2), product_duplicate.calculate_certainty_percentage(possible_dup: potential_duplicate_product))
  end

  test 'calculate certainty percentage after adding same item pack name' do
    product = products(:lager)
    potential_duplicate_product = build_stubbed(
      :product,
      item_description_similarity: 1.0,
      brand_similarity: 1.0,
      item_pack_name: product.item_pack_name,
      item_measure: 'fake',
      item_sell_pack_name: 'fake',
      median_price: 0,
      item_size: 0,
      item_sell_quantity: 0
    )
    product_duplicate = build_stubbed(
      :product_duplicate,
      product: product,
      potential_duplicate_product: potential_duplicate_product
    )
    assert_equal(BigDecimal(0.56, 2), product_duplicate.calculate_certainty_percentage(possible_dup: potential_duplicate_product))
  end

  test 'calculate certainty percentage after adding same item measure' do
    product = products(:lager)
    potential_duplicate_product = build_stubbed(
      :product,
      item_description_similarity: 1.0,
      brand_similarity: 1.0,
      item_pack_name: product.item_pack_name,
      item_measure: product.item_measure,
      item_sell_pack_name: 'fake',
      median_price: 0,
      item_size: 0,
      item_sell_quantity: 0
    )
    product_duplicate = build_stubbed(
      :product_duplicate,
      product: product,
      potential_duplicate_product: potential_duplicate_product
    )
    assert_equal(BigDecimal(0.61, 2), product_duplicate.calculate_certainty_percentage(possible_dup: potential_duplicate_product))
  end

  test 'calculate certainty percentage after adding same item sell pack name' do
    product = products(:lager)
    potential_duplicate_product = build_stubbed(
      :product,
      item_description_similarity: 1.0,
      brand_similarity: 1.0,
      item_pack_name: product.item_pack_name,
      item_measure: product.item_measure,
      item_sell_pack_name: product.item_sell_pack_name,
      median_price: 0,
      item_size: 0,
      item_sell_quantity: 0
    )
    product_duplicate = build_stubbed(
      :product_duplicate,
      product: product,
      potential_duplicate_product: potential_duplicate_product
    )
    assert_equal(BigDecimal(0.66, 2), product_duplicate.calculate_certainty_percentage(possible_dup: potential_duplicate_product))
  end

  test 'calculate certainty percentage after adding same median price' do
    product = products(:lager)
    potential_duplicate_product = build_stubbed(
      :product,
      item_description_similarity: 1.0,
      brand_similarity: 1.0,
      item_pack_name: product.item_pack_name,
      item_measure: product.item_measure,
      item_sell_pack_name: product.item_sell_pack_name,
      median_price: product.median_price,
      item_size: 0,
      item_sell_quantity: 0
    )
    product_duplicate = build_stubbed(
      :product_duplicate,
      product: product,
      potential_duplicate_product: potential_duplicate_product
    )
    assert_equal(BigDecimal(0.72, 2), product_duplicate.calculate_certainty_percentage(possible_dup: potential_duplicate_product))
  end

  test 'calculate certainty percentage after adding same item size' do
    product = products(:lager)
    potential_duplicate_product = build_stubbed(
      :product,
      item_description_similarity: 1.0,
      brand_similarity: 1.0,
      item_pack_name: product.item_pack_name,
      item_measure: product.item_measure,
      item_sell_pack_name: product.item_sell_pack_name,
      median_price: product.median_price,
      item_size: product.item_size,
      item_sell_quantity: 0
    )
    product_duplicate = build_stubbed(
      :product_duplicate,
      product: product,
      potential_duplicate_product: potential_duplicate_product
    )
    assert_equal(BigDecimal(0.9, 2), product_duplicate.calculate_certainty_percentage(possible_dup: potential_duplicate_product))
  end

  test 'calculate certainty percentage after adding same item sell quantity' do
    product = products(:lager)
    potential_duplicate_product = build_stubbed(
      :product,
      item_description_similarity: 1.0,
      brand_similarity: 1.0,
      item_pack_name: product.item_pack_name,
      item_measure: product.item_measure,
      item_sell_pack_name: product.item_sell_pack_name,
      median_price: product.median_price,
      item_size: product.item_size,
      item_sell_quantity: product.item_sell_quantity
    )
    product_duplicate = build_stubbed(
      :product_duplicate,
      product: product,
      potential_duplicate_product: potential_duplicate_product
    )
    assert_equal(BigDecimal(1.0, 2), product_duplicate.calculate_certainty_percentage(possible_dup: potential_duplicate_product))
  end
end
