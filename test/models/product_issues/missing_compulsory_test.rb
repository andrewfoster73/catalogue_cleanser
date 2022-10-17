# frozen_string_literal: true

require 'test_helper'

class ProductIssues::MissingCompulsoryTest < ActiveSupport::TestCase
  test 'initial status is confirmed' do
    product = build_stubbed(:product)
    issue = ProductIssues::MissingCompulsory.new(product: product)
    assert_equal('confirmed', issue.status)
  end

  test 'should return true if the attribute is nil' do
    product = build_stubbed(:product, item_description: nil)
    issue = ProductIssues::MissingCompulsory.issue?(**{ product: product, attribute: :item_description })
    assert_equal(true, issue)

    product_translation = build_stubbed(:product_translation, product: product, item_description: nil)
    issue = ProductIssues::MissingCompulsory.issue?(**{
      product: product, product_translation: product_translation, attribute: :item_description
    }
    )
    assert_equal(true, issue)
  end

  test 'should return true if the attribute is an empty string' do
    product = build_stubbed(:product, item_description: '')
    issue = ProductIssues::MissingCompulsory.issue?(**{ product: product, attribute: :item_description })
    assert_equal(true, issue)

    product_translation = build_stubbed(:product_translation, product: product, item_description: '')
    issue = ProductIssues::MissingCompulsory.issue?(**{
      product: product, product_translation: product_translation, attribute: :item_description
    }
    )
    assert_equal(true, issue)
  end

  test 'should return true if the attribute is only spaces' do
    product = build_stubbed(:product, item_description: '   ')
    issue = ProductIssues::MissingCompulsory.issue?(**{ product: product, attribute: :item_description })
    assert_equal(true, issue)

    product_translation = build_stubbed(:product_translation, product: product, item_description: '    ')
    issue = ProductIssues::MissingCompulsory.issue?(**{
      product: product, product_translation: product_translation, attribute: :item_description
    }
    )
    assert_equal(true, issue)
  end

  test 'should return false for no issues' do
    product = build_stubbed(:product, item_description: 'This is fine')
    issue = ProductIssues::MissingCompulsory.issue?(**{ product: product, attribute: :item_description })
    assert_equal(false, issue)

    product_translation = build_stubbed(:product_translation, product: product, item_description: 'This is fine')
    issue = ProductIssues::MissingCompulsory.issue?(**{
      product: product, product_translation: product_translation, attribute: :item_description
    }
    )
    assert_equal(false, issue)
  end

  test 'should return true if there is no product or translation' do
    issue = ProductIssues::MissingCompulsory.issue?(**{ product: nil, attribute: :item_description })
    assert_equal(true, issue)
  end
end
