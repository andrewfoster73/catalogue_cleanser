# frozen_string_literal: true

require 'test_helper'

class Tasks::GatherPotentialDuplicatesTest < ActiveSupport::TestCase
  setup do
    @product = products(:lager)
    @potential_duplicate = create(:product, item_description: 'lger', brand: 'Innis Gunn')
    @task = Tasks::GatherPotentialDuplicates.create!
  end

  test 'updates counts on products' do
    assert_equal('pending', @task.status, 'Task initial status is not pending')
    @task.call
    assert_equal('complete', @task.reload.status)
    assert_equal(4, ProductDuplicate.count)
    assert_equal(1, @product.reload.product_duplicates.size)
  end
end
