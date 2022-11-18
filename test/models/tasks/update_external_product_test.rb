# frozen_string_literal: true

require 'test_helper'

class Tasks::UpdateExternalProductTest < ActiveSupport::TestCase
  setup do
    @product = products(:lager)
    @master_catalogue = create(:external_catalogue)
    @external_catalogued_product = create(:external_catalogued_product, external_product: @product.external_product)
  end

  test 'updates external product' do
    @product.update!(item_description: 'Tasty Lager')
    @task = Tasks::UpdateExternalProduct.create!(context: @product)
    @task.call
    assert_equal('Tasty Lager', @product.external_product.reload.item_description)
  end

  test 'is executable if changed attributes are relevant' do
    @product.update!(item_description: 'Tasty Lager')
    assert_equal(true, Tasks::UpdateExternalProduct.executable?(@product.previous_changes))
  end

  test 'is not executable if changed attributes are not relevant' do
    @product.update!(catalogue_count: 5)
    assert_equal(false, Tasks::UpdateExternalProduct.executable?(@product.previous_changes))
  end
end
