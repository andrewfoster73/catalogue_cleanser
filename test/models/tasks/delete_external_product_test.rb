# frozen_string_literal: true

require 'test_helper'

class Tasks::DeleteExternalProductTest < ActiveSupport::TestCase
  setup do
    @product = products(:lager)
    @master_catalogue = create(:external_catalogue)
    @external_catalogued_product = create(:external_catalogued_product, external_product: @product.external_product)
  end

  test 'deletes external product' do
    @task = Tasks::DeleteExternalProduct.create!(context: @product)
    @task.call
    assert_nil(@product.reload.external_product)
  end

  test 'raises error' do
    create(:external_requisition_line_item,
           external_product: @product.external_product, requisition_id: 1, vendor_id: 1
    )
    @task = Tasks::DeleteExternalProduct.create!(context: @product)
    assert_raises(ActiveRecord::InvalidForeignKey) do
      @task.call
    end
    assert_equal('error', @task.reload.status)
  end
end
