# frozen_string_literal: true

require 'test_helper'

class ProductIssueTest < ActiveSupport::TestCase
  test 'initial status is pending' do
    product = build_stubbed(:product)
    issue = ProductIssue.new(product: product)
    assert_equal('pending', issue.status)
  end

  test 'parent when it is a product' do
    product = build_stubbed(:product)
    issue = ProductIssue.new(product: product)
    assert_equal(product, issue.parent)
  end

  test 'parent when it is a product translation' do
    product = build_stubbed(:product)
    translation = build_stubbed(:product_translation, product: product)
    issue = ProductIssue.new(product: product, product_translation: translation)
    assert_equal(translation, issue.parent)
  end

  test 'to_s when it is a product' do
    product = build_stubbed(:product)
    issue = ProductIssues::MissingCompulsory.new(product: product)
    assert_equal('Missing Compulsory Attribute - Lager', issue.to_s)
  end

  test 'to_s when it is a product translation' do
    product = build_stubbed(:product)
    translation = build_stubbed(:product_translation, product: product)
    issue = ProductIssues::InvalidLocale.new(product: product, product_translation: translation)
    assert_equal('Invalid Locale - Lager (en)', issue.to_s)
  end

  test 'is outstanding unless fixed or ignored' do
    product = build_stubbed(:product)
    issue = ProductIssue.new(product: product)
    assert_equal(true, issue.outstanding?)
    issue.status = 'confirmed'
    assert_equal(true, issue.outstanding?)
    issue.status = 'fixed'
    assert_equal(false, issue.outstanding?)
    issue.status = 'ignored'
    assert_equal(false, issue.outstanding?)
  end
end
