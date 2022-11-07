# frozen_string_literal: true

require 'test_helper'

class Tasks::InitialiseBrandsTest < ActiveSupport::TestCase
  setup do
    @external_product = create(:external_product, brand: 'Too    many spaces  ')
    @duplicate_product = create(:external_product, brand: 'Too many spaces')
    @master_catalogue = create(:external_catalogue)
    @external_catalogued_product = create(:external_catalogued_product, external_product: @external_product)
    @duplicate_catalogued_product = create(:external_catalogued_product, external_product: @duplicate_product)
    @task = Tasks::InitialiseBrands.create!
  end

  test 'creates brands' do
    assert_equal('pending', @task.status, 'Task initial status is not pending')
    @task.call
    assert_equal(1, Brand.imported.count, 'Number of Brands created is not 1')
    assert_equal('complete', @task.status, 'Task final status is not complete')
  end
end
