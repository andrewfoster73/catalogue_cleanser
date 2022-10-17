# frozen_string_literal: true

require 'test_helper'

class ProductIssues::AdditionalWhitespaceTest < ActiveSupport::TestCase
  test 'initial status is confirmed' do
    product = build_stubbed(:product)
    issue = ProductIssues::AdditionalWhitespace.new(product: product)
    assert_equal('confirmed', issue.status)
  end

  test 'should return true if there is leading whitespace' do
    product = build_stubbed(:product, item_description: ' This is not fine')
    issue = ProductIssues::AdditionalWhitespace.issue?(**{ product: product, attribute: :item_description })
    assert_equal(true, issue)

    product_translation = build_stubbed(:product_translation, product: product, item_description: ' This is not fine')
    issue = ProductIssues::AdditionalWhitespace.issue?(**{
      product: product, product_translation: product_translation, attribute: :item_description
    }
    )
    assert_equal(true, issue)
  end

  test 'should return true if there is trailing whitespace' do
    product = build_stubbed(:product, item_description: 'This is not fine ')
    issue = ProductIssues::AdditionalWhitespace.issue?(**{ product: product, attribute: :item_description })
    assert_equal(true, issue)

    product_translation = build_stubbed(:product_translation, product: product, item_description: 'This is not fine ')
    issue = ProductIssues::AdditionalWhitespace.issue?(**{
      product: product, product_translation: product_translation, attribute: :item_description
    }
    )
    assert_equal(true, issue)
  end

  test 'should return true if there is multiple spaces' do
    product = build_stubbed(:product, item_description: 'This is   not fine')
    issue = ProductIssues::AdditionalWhitespace.issue?(**{ product: product, attribute: :item_description })
    assert_equal(true, issue)

    product_translation = build_stubbed(:product_translation, product: product, item_description: 'This   is not fine')
    issue = ProductIssues::AdditionalWhitespace.issue?(**{
      product: product, product_translation: product_translation, attribute: :item_description
    }
    )
    assert_equal(true, issue)
  end

  test 'should return false for no issues' do
    product = build_stubbed(:product, item_description: 'This is fine')
    issue = ProductIssues::AdditionalWhitespace.issue?(**{ product: product, attribute: :item_description })
    assert_equal(false, issue)

    product_translation = build_stubbed(:product_translation, product: product, item_description: 'This is fine')
    issue = ProductIssues::AdditionalWhitespace.issue?(**{
      product: product, product_translation: product_translation, attribute: :item_description
    }
    )
    assert_equal(false, issue)
  end

  test 'should return true if there is no product or translation' do
    issue = ProductIssues::AdditionalWhitespace.issue?(**{ product: nil, attribute: :item_description })
    assert_equal(true, issue)
  end
end
