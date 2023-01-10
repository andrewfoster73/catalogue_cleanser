# frozen_string_literal: true

require 'test_helper'

class ProductIssues::UnusedProductTest < ActiveSupport::TestCase
  test 'initial status is confirmed' do
    product = build_stubbed(:product)
    issue = ProductIssues::UnusedProduct.new(product: product)
    assert_equal('confirmed', issue.status)
  end

  test 'should return true if the product is not in use' do
    product = create(:product, collected_usage_at: Time.zone.now)
    issue = ProductIssues::UnusedProduct.issue?(**{ product: product })
    assert_equal(true, issue)

    # Do not care about translations for this type of issue
    product_translation = build_stubbed(:product_translation, product: product)
    issue = ProductIssues::UnusedProduct.issue?(**{ product: product, product_translation: product_translation })
    assert_equal(false, issue)
  end

  test 'should return false for no issues' do
    product = create(:product, collected_usage_at: Time.zone.now, requisition_line_items_count: 1)
    issue = ProductIssues::UnusedProduct.issue?(**{ product: product })
    assert_equal(false, issue)

    product_translation = build_stubbed(:product_translation, product: product)
    issue = ProductIssues::UnusedProduct.issue?(**{ product: product, product_translation: product_translation })
    assert_equal(false, issue)
  end

  test 'fix! should create DeleteProduct task' do
    product = create(:product, collected_usage_at: Time.zone.now)
    issue = ProductIssues::UnusedProduct.create!(product: product)
    assert_changes(-> { Tasks::DeleteExternalProduct.count }) do
      issue.fix!
      issue.reload
      assert_equal('Tasks::DeleteExternalProduct', issue.resolution_task_type)
    end
  end
end
