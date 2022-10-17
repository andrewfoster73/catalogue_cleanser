# frozen_string_literal: true

require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  test 'external product presence validation' do
    product = build(:product, external_product: nil)
    assert_not(product.save, 'Saved the product without required attributes')
  end

  test 'external product uniqueness validation' do
    product = build(:product, external_product: external_products(:lager))
    assert_not(product.save, 'Saved the product using a duplicate external product')
  end

  test 'discovering issues when there are none' do
    product = build(:product, external_product: external_products(:lager))
    assert_no_difference('ProductIssue.count') do
      product.discover_issues!
    end
  end

  test 'discovering new issues' do
    product = build(:product, item_description: nil, item_measure: ' ml')
    assert_difference('ProductIssue.count', 2) do
      product.discover_issues!
    end
  end

  test 'discovering issues when they have already been discovered' do
    product = build(:product, item_description: nil, item_measure: ' ml')
    assert_difference('ProductIssue.count', 2) do
      product.discover_issues!
      product.discover_issues!
    end
  end

  test 're-discovering issues when they have already been fixed' do
    product = create(:product, item_description: nil)
    product = Product.includes(:product_translations).find(product.id)
    create(:product_issue,
           type: 'ProductIssues::MissingCompulsory',
           product: product,
           test_attribute: :item_description,
           status: :fixed
          )
    assert_difference('ProductIssue.count', 1) do
      product.discover_issues!
    end
  end

  test 'discovering issues should include translation issues' do
    product = create(:product)
    create(:product_translation, product: product, locale: 'fr')
    product = Product.includes(:product_translations).find(product.id)
    assert_difference('ProductIssue.count', 1) do
      product.discover_issues!
    end
  end

  test 'fixing issues when they are still an issue' do
    product = create(:product, item_description: nil, item_measure: ' ml')
    product = Product.includes(:product_translations, :product_issues).find(product.id)
    assert_difference('ProductIssue.count', 2) do
      product.discover_issues!
    end
    assert_difference('ProductIssue.fixed.count', 1) do
      product.update!(item_description: 'fixed')
      product.resolve_issues!
    end
  end

  test 'fixing issues when they have been resolved' do
    product = create(:product, item_description: nil, item_measure: ' ml')
    product = Product.includes(:product_translations, :product_issues).find(product.id)
    assert_difference('ProductIssue.count', 2) do
      product.discover_issues!
    end
    assert_difference('ProductIssue.fixed.count', 2) do
      product.update!(item_description: 'fixed', item_measure: 'ml')
      product.resolve_issues!
    end
  end
end
