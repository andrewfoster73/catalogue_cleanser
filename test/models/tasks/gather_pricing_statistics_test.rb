# frozen_string_literal: true

require 'test_helper'

class Tasks::GatherPricingStatisticsTest < ActiveSupport::TestCase
  setup do
    @product = products(:lager)
    @master_catalogue = create(:external_catalogue)
    @external_catalogued_product = create(:external_catalogued_product, external_product: @product.external_product)
    @dummy_organisation = create(:external_organisation, postal_address_country: 'AU')
    @priced_catalogue = create(
      :external_catalogue,
      title: 'Price Structure',
      catalogue_type: 'Priced',
      id: 2,
      owner_id: @dummy_organisation.id
    )
    @external_priced_catalogued_product = create(
      :external_catalogued_product,
      product_id: @product.external_product_id,
      catalogue: @priced_catalogue,
      sell_unit_price: 12.99
    )
    @task = Tasks::GatherPricingStatistics.create!
  end

  test 'updates counts on products' do
    assert_equal('pending', @task.status, 'Task initial status is not pending')
    assert_changes(-> { @product.reload.collected_pricing_at }) do
      @task.call
    end
    @product.reload
    assert_equal(1, @product.price_count)
    assert_equal(12.99, @product.minimum_price)
    assert_equal('complete', @task.reload.status)
  end
end
