# frozen_string_literal: true

require 'test_helper'

class ProductIssues::PotentialDuplicationTest < ActiveSupport::TestCase
  test 'initial status is pending' do
    product = build_stubbed(:product)
    issue = ProductIssues::PotentialDuplication.new(product: product)
    assert_equal('pending', issue.status)
  end

  test 'should return false if the parent is a product translation' do
    product = build_stubbed(:product)
    product_translation = build_stubbed(:product_translation, product: product)
    issue = ProductIssues::PotentialDuplication.issue?(**{ product: product, product_translation: product_translation })
    assert_equal(false, issue)
  end

  test 'should return false if the duplication_certainty has not been populated yet' do
    product = build_stubbed(:product)
    issue = ProductIssues::PotentialDuplication.issue?(**{ product: product })
    assert_equal(false, issue)
  end

  test 'should return false if the duplication_certainty is below the ProductDuplicate::MINIMUM_CERTAINTY_PERCENTAGE' do
    product = build_stubbed(:product, duplication_certainty: ProductDuplicate::MINIMUM_CERTAINTY_PERCENTAGE - 0.3)
    issue = ProductIssues::PotentialDuplication.issue?(**{ product: product })
    assert_equal(false, issue)
  end

  test 'should return true if the duplication_certainty is above the ProductDuplicate::MINIMUM_CERTAINTY_PERCENTAGE' do
    product = build_stubbed(:product, duplication_certainty: ProductDuplicate::MINIMUM_CERTAINTY_PERCENTAGE + 0.05)
    issue = ProductIssues::PotentialDuplication.issue?(**{ product: product })
    assert_equal(true, issue)
  end
end