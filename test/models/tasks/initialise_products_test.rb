# frozen_string_literal: true

require 'test_helper'

class Tasks::InitialiseProductsTest < ActiveSupport::TestCase
  setup do
    @external_product = create(:external_product, item_description: 'Too    many spaces  ')
    @external_translation = create(:external_product_translation, external_product: @external_product)
    @master_catalogue = create(:external_catalogue)
    @external_catalogued_product = create(:external_catalogued_product, external_product: @external_product)
    @task = Tasks::InitialiseProducts.create!
  end

  test 'creates products and translations' do
    assert_equal('pending', @task.status, 'Task initial status is not pending')
    @task.call
    assert_equal(1, Product.imported.count, 'Number of Products created is not 1')
    assert_equal(1, ProductTranslation.imported.count, 'Number of Product Translations created is not 3')
    assert_equal(5, ProductIssue.count, 'Number of Product Issues is not 5')
    assert_equal('complete', @task.status, 'Task final status is not complete')
  end
end
