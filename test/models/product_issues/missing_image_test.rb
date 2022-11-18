# frozen_string_literal: true

require 'test_helper'

class ProductIssues::MissingImageTest < ActiveSupport::TestCase
  test 'initial status is confirmed' do
    product = build_stubbed(:product)
    issue = ProductIssues::MissingImage.new(product: product, test_attribute: :image_file_name)
    assert_equal('confirmed', issue.status)
  end

  test 'should return true if the image_file_name is blank' do
    product = build_stubbed(:product, image_file_name: '  ')
    issue = ProductIssues::MissingImage.issue?(**{ product: product })
    assert_equal(true, issue)
  end

  test 'should return true if the image_file_name is nil' do
    product = build_stubbed(:product, image_file_name: nil)
    issue = ProductIssues::MissingImage.issue?(**{ product: product })
    assert_equal(true, issue)
  end

  test 'should return false for a valid image_file_name' do
    product = build_stubbed(:product, image_file_name: '/some/url')
    issue = ProductIssues::MissingImage.issue?(**{ product: product })
    assert_equal(false, issue)
  end

  test 'should return true if there is no product' do
    issue = ProductIssues::MissingImage.issue?(**{ product: nil })
    assert_equal(true, issue)
  end

  test 'should return false for the product translation' do
    product = build_stubbed(:product, image_file_name: '/some/url')
    product_translation = build_stubbed(:product_translation, product: product)
    issue = ProductIssues::MissingImage.issue?(**{ product: product, product_translation: product_translation })
    assert_equal(false, issue)
  end
end
