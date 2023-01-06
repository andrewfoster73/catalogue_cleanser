# frozen_string_literal: true

require 'test_helper'

class Tasks::GatherUsageStatisticsTest < ActiveSupport::TestCase
  setup do
    @product = products(:lager)
    @master_catalogue = create(:external_catalogue)
    @external_catalogued_product = create(:external_catalogued_product, external_product: @product.external_product)
    @requisition_line_item = create(
      :external_requisition_line_item,
      product_id: @product.external_product_id,
      requisition_id: 1,
      vendor_id: 1
    )
    @task = Tasks::GatherUsageStatistics.create!
  end

  test 'updates counts on products' do
    assert_changes(-> { @product.reload.collected_statistics_at }) do
      @task.call
    end
    assert_equal('complete', @task.reload.status)
  end
end
