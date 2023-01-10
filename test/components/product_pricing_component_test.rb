# frozen_string_literal: true

require 'test_helper'

class ProductPricing::ComponentTest < ViewComponent::TestCase
  def setup
    @product = products(:lager)
  end

  test 'renders usage ranking and counts' do
    render_inline ProductPricing::Component.new(resource: @product)

    assert_selector("#product_#{@product.id}--product_pricing_heading", text: 'Pricing Statistics')
    assert_selector("#product_#{@product.id}--product_pricing_timestamp", text: 'Last collected at')
    assert_selector("#product_#{@product.id}--product_pricing_country", text: 'Australia')
    assert_selector("#product_#{@product.id}--minimum_price__heading", text: 'Minimum')
    assert_selector("#product_#{@product.id}--minimum_price__value", text: '$9.99')
    assert_selector("#product_#{@product.id}--maximum_price__heading", text: 'Maximum')
    assert_selector("#product_#{@product.id}--maximum_price__value", text: '$9.99')
    assert_selector("#product_#{@product.id}--average_price__heading", text: 'Average')
    assert_selector("#product_#{@product.id}--average_price__value", text: '$9.99')
    assert_selector("#product_#{@product.id}--median_price__heading", text: 'Median')
    assert_selector("#product_#{@product.id}--median_price__value", text: '$9.99')
    assert_selector("#product_#{@product.id}--price_count__heading", text: 'Count')
    assert_selector("#product_#{@product.id}--price_count__value", text: '1')
    assert_selector("#product_#{@product.id}--standard_deviation__heading", text: 'Standard Deviation')
    assert_selector("#product_#{@product.id}--standard_deviation__value", text: '$9.99')
    assert_selector("#product_#{@product.id}--coefficient_of_variation__heading", text: 'Coefficient of Variation')
    assert_selector("#product_#{@product.id}--coefficient_of_variation__value", text: '1')
    assert_selector("#product_#{@product.id}--confidence_interval__heading", text: 'Confidence (95%)')
    assert_selector("#product_#{@product.id}--confidence_interval__value", text: '1')
  end

  test 'handles products that have no pricing information' do
    @product = products(:mince)
    render_inline ProductPricing::Component.new(resource: @product)

    assert_selector("#product_#{@product.id}--product_pricing_heading", text: 'Pricing Statistics')
    assert_selector(
      "#product_#{@product.id}--product_pricing_timestamp",
      text: 'Pricing not collected yet or does not have a non-zero price available.'
    )
    assert_selector("#product_#{@product.id}--minimum_price__heading", text: 'Minimum')
    assert_selector("#product_#{@product.id}--minimum_price__value", text: 'None')
    assert_selector("#product_#{@product.id}--maximum_price__heading", text: 'Maximum')
    assert_selector("#product_#{@product.id}--maximum_price__value", text: 'None')
    assert_selector("#product_#{@product.id}--average_price__heading", text: 'Average')
    assert_selector("#product_#{@product.id}--average_price__value", text: 'None')
    assert_selector("#product_#{@product.id}--median_price__heading", text: 'Median')
    assert_selector("#product_#{@product.id}--median_price__value", text: 'None')
    assert_selector("#product_#{@product.id}--price_count__heading", text: 'Count')
    assert_selector("#product_#{@product.id}--price_count__value", text: '0')
    assert_selector("#product_#{@product.id}--standard_deviation__heading", text: 'Standard Deviation')
    assert_selector("#product_#{@product.id}--standard_deviation__value", text: 'None')
    assert_selector("#product_#{@product.id}--coefficient_of_variation__heading", text: 'Coefficient of Variation')
    assert_selector("#product_#{@product.id}--coefficient_of_variation__value", text: 'None')
    assert_selector("#product_#{@product.id}--confidence_interval__heading", text: 'Confidence (95%)')
    assert_selector("#product_#{@product.id}--confidence_interval__value", text: 'None')
  end
end
