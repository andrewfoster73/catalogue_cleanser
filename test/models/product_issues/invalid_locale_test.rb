# frozen_string_literal: true

require 'test_helper'

class ProductIssues::InvalidLocaleTest < ActiveSupport::TestCase
  test 'initial status is confirmed' do
    product = build_stubbed(:product)
    issue = ProductIssues::InvalidLocale.new(product: product, test_attribute: :locale)
    assert_equal('confirmed', issue.status)
  end

  test 'should return true if the locale is not one of the supported locales' do
    product = build_stubbed(:product, locale: 'fr')
    issue = ProductIssues::InvalidLocale.issue?(**{ product: product, attribute: :locale })
    assert_equal(true, issue)

    product_translation = build_stubbed(:product_translation, locale: 'fr')
    issue = ProductIssues::InvalidLocale.issue?(**{
      product: product, product_translation: product_translation, attribute: :locale
    }
    )
    assert_equal(true, issue)
  end

  test 'should return false for a valid locale' do
    product = build_stubbed(:product, locale: 'en')
    issue = ProductIssues::InvalidLocale.issue?(**{ product: product, attribute: :locale })
    assert_equal(false, issue)

    product_translation = build_stubbed(:product_translation, locale: 'en')
    issue = ProductIssues::InvalidLocale.issue?(**{
      product: product, product_translation: product_translation, attribute: :locale
    }
    )
    assert_equal(false, issue)
  end

  test 'should return true if there is no product or translation' do
    issue = ProductIssues::InvalidLocale.issue?(**{ product: nil, attribute: :locale })
    assert_equal(true, issue)
  end
end
