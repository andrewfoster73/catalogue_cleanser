# frozen_string_literal: true

require 'test_helper'

class Tasks::StripWhitespaceTest < ActiveSupport::TestCase
  setup do
    @product = create(:product, item_description: 'This is   not fine')
    @issue = ProductIssues::AdditionalWhitespace.create!(
      product: @product,
      test_attribute: 'item_description',
      resolution_suggested_replacement: 'This is not fine',
      resolution_task_type: 'Tasks::StripWhitespace'
    )
  end

  test 'updates product attribute' do
    @task = Tasks::StripWhitespace.create!(context: @product, product_issue: @issue)
    @task.call
    assert_equal('This is not fine', @product.reload.item_description)
    assert_equal('This is not fine', @product.external_product.reload.item_description)
    assert_equal('fixed', @issue.reload.status)
  end
end
