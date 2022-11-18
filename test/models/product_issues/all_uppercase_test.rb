# frozen_string_literal: true

require 'test_helper'

class ProductIssues::AllUppercaseTest < ActiveSupport::TestCase
  test 'initial status is pending' do
    product = build_stubbed(:product)
    issue = ProductIssues::AllUppercase.new(product: product, test_attribute: :item_description)
    assert_equal('pending', issue.status)
  end

  test 'should return true if the item_description is all upper case' do
    product = build_stubbed(:product, item_description: 'TENDERLOIN ')
    issue = ProductIssues::AllUppercase.issue?(**{ product: product, attribute: :item_description })
    assert_equal(true, issue)
  end

  test 'should return false for a valid item_description' do
    product = build_stubbed(:product, item_description: 'Tenderloin')
    issue = ProductIssues::AllUppercase.issue?(**{ product: product, attribute: :item_description })
    assert_equal(false, issue)
  end

  test 'should return false if there are no letters in the item_description' do
    product = build_stubbed(:product, item_description: '#1234')
    issue = ProductIssues::AllUppercase.issue?(**{ product: product, attribute: :item_description })
    assert_equal(false, issue)
  end

  test 'should return false if the item_description is blank' do
    product = build_stubbed(:product, item_description: nil)
    issue = ProductIssues::AllUppercase.issue?(**{ product: product, attribute: :item_description })
    assert_equal(false, issue)
  end

  test 'should return true if there is no product' do
    issue = ProductIssues::AllUppercase.issue?(**{ product: nil, attribute: :item_description })
    assert_equal(true, issue)
  end
end
