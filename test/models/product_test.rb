# frozen_string_literal: true

require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  test 'cleaning' do
    product = build(
      :product, item_description: ' iPhone 14  Pro Max   ', brand: " Apple (U.S.A.)  \n", data_source: 'manual'
    )
    product.valid?
    assert_equal('iPhone 14 Pro Max', product.item_description, 'Item description contains illegal whitespace')
    assert_equal('Apple (U.S.A.)', product.brand, 'Brand contains illegal whitespace')
  end

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
      product.discover_and_fix_issues!
    end
  end

  test 'discovering new issues' do
    product = build(:product, item_description: nil, item_measure: ' ml')
    assert_difference('ProductIssue.count', 2) do
      product.discover_and_fix_issues!
    end
  end

  test 'discovering issues when they have already been discovered' do
    product = build(:product, item_description: nil, item_measure: ' ml')
    assert_difference('ProductIssue.count', 2) do
      product.discover_and_fix_issues!
      product.discover_and_fix_issues!
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
      product.discover_and_fix_issues!
    end
  end

  test 'discovering issues should include translation issues' do
    product = create(:product)
    create(:product_translation, product: product, locale: 'fr')
    product = Product.includes(:product_translations).find(product.id)
    assert_difference('ProductIssue.count', 1) do
      product.discover_and_fix_issues!
    end
  end

  test 'not fixing issues when they are still an issue' do
    product = create(:product, item_description: nil, item_measure: nil)
    product = Product.includes(:product_translations, :product_issues).find(product.id)
    assert_difference('ProductIssue.count', 2) do
      product.discover_and_fix_issues!
    end
    assert_difference('ProductIssue.fixed.count', 1) do
      product.update!(item_description: 'fixed')
      product.resolve_issues!
    end
  end

  test 'fixing issues when they have been resolved' do
    product = create(:product, item_description: nil, item_measure: nil)
    product = Product.includes(:product_translations, :product_issues).find(product.id)
    assert_difference('ProductIssue.count', 2) do
      product.discover_and_fix_issues!
    end
    assert_difference('ProductIssue.fixed.count', 2) do
      product.update!(item_description: 'fixed', item_measure: 'ml')
      product.resolve_issues!
    end
  end

  test 'automatically fixing issues when possible' do
    product = create(:product, item_description: nil, item_measure: ' ml')
    product = Product.includes(:product_translations, :product_issues).find(product.id)
    product.discover_and_fix_issues!
    assert_equal(1, ProductIssue.where(product: product).fixed.count)
    assert_equal(2, ProductIssue.where(product: product).count)
  end

  test 'used?' do
    # When used in a transaction / catalogue / setting
    assert_equal(true, products(:lager).used?)
    # When not used anywhere
    zero_usage_product = create(:product)
    assert_equal(false, zero_usage_product.used?)
  end

  test 'transaction usage count' do
    assert_equal(76.0, products(:lager).transaction_usage_count)
    assert_equal(174.0, products(:apple).transaction_usage_count)
    assert_equal(72.0, products(:mince).transaction_usage_count)
  end

  test 'transaction usage ranking' do
    zero_usage_product = create(:product)
    assert_equal('none', zero_usage_product.transaction_usage_ranking)
    assert_equal('lowest', products(:lager).transaction_usage_ranking)
    assert_equal('high', products(:apple).transaction_usage_ranking)
    assert_equal('lowest', products(:mince).transaction_usage_ranking)
  end

  test 'catalogue usage count' do
    assert_equal(27.0, products(:lager).catalogue_usage_count)
    assert_equal(33.0, products(:apple).catalogue_usage_count)
    assert_equal(7.0, products(:mince).catalogue_usage_count)
  end

  test 'catalogue usage ranking' do
    zero_usage_product = create(:product)
    assert_equal('none', zero_usage_product.catalogue_usage_ranking)
    assert_equal('low', products(:lager).catalogue_usage_ranking)
    assert_equal('high', products(:apple).catalogue_usage_ranking)
    assert_equal('lowest', products(:mince).catalogue_usage_ranking)
  end

  test 'settings usage count' do
    assert_equal(23.0, products(:lager).settings_usage_count)
    assert_equal(41.0, products(:apple).settings_usage_count)
    assert_equal(11.0, products(:mince).settings_usage_count)
  end

  test 'settings usage ranking' do
    zero_usage_product = create(:product)
    assert_equal('none', zero_usage_product.settings_usage_ranking)
    assert_equal('low', products(:lager).settings_usage_ranking)
    assert_equal('high', products(:apple).settings_usage_ranking)
    assert_equal('lowest', products(:mince).settings_usage_ranking)
  end

  test 'updating and propagating to external product if relevant attribute changed' do
    product = products(:lager)
    assert_changes(-> { Tasks::UpdateExternalProduct.where(context_id: product.id).size }) do
      product.update_and_propagate(item_description: 'Tasty Lager')
    end
  end

  test 'updating without propagating if relevant attribute not changed' do
    product = products(:lager)
    assert_no_changes(-> { Tasks::UpdateExternalProduct.where(context_id: product.id).size }) do
      product.update_and_propagate(catalogue_count: 5)
    end
  end

  test 'unsuccessful update should not trigger external product update' do
    product = products(:lager)
    assert_no_changes(-> { Tasks::UpdateExternalProduct.where(context_id: product.id).size }) do
      product.update_and_propagate(item_description: 'Tasty Lager', catalogue_count: -1)
    end
  end

  test 'generating a long description' do
    assert_equal(
      "Innis & Gunn Lager 500ml bottle carton of 6 [PPID: #{products(:lager).external_product_id}]",
      products(:lager).long_description
    )
    assert_equal(
      "Apple 1kg each [PPID: #{products(:apple).external_product_id}]",
      products(:apple).long_description
    )
    assert_equal(
      "Coles Beef Mince 500g packet each [PPID: #{products(:mince).external_product_id}]",
      products(:mince).long_description
    )
  end

  test 'generating a sell size description' do
    assert_equal('carton of 6', products(:lager).sell_size_description)
    assert_equal('each', products(:apple).sell_size_description)
  end

  test 'calculating certainty of duplication when there are no duplicates' do
    assert_equal(0, products(:lager).calculate_duplication_certainty)
  end

  test 'calculating certainty of duplication when there are duplicates but no likely ones' do
    product = Product.includes(:product_duplicates).find(products(:lager).id)
    create(:product_duplicate, product: product, certainty_percentage: 0.75)
    assert_equal(0, product.calculate_duplication_certainty)
  end

  test 'calculating certainty of duplication when there are duplicates' do
    product = Product.includes(:product_duplicates).find(products(:lager).id)
    create(:product_duplicate, product: product, certainty_percentage: 0.75)
    create(:product_duplicate, product: product, certainty_percentage: 1.00)
    create(:product_duplicate, product: product, certainty_percentage: 0.9)
    assert_equal(0.95, product.calculate_duplication_certainty)
  end

  test 'calculating certainty of being canonical when there are no duplicates' do
    product = create(:product)
    assert_equal(1.0, product.calculate_canonical_certainty)
  end

  test 'calculating certainty of being canonical when there are issues' do
    product = create(:product)
    create(:product_issue,
      type: 'ProductIssues::MissingCompulsory',
      product: product,
      test_attribute: :item_description
    )
    potential_duplicate_product = create(
      :product,
      item_description_similarity: 1.0,
      brand_similarity: 0.0,
      item_pack_name: 'fake',
      item_measure: 'fake',
      item_sell_pack_name: 'fake',
      median_price: 0,
      item_size: 0,
      item_sell_quantity: 0
    )
    create(:product_duplicate,
      product: product,
      certainty_percentage: 1.00,
      potential_duplicate_product: potential_duplicate_product
    )
    assert_equal(0.85, product.reload.calculate_canonical_certainty)
  end

  test 'calculating certainty of being canonical when there is no image attached' do
    product = create(:product, image_file_name: nil)
    potential_duplicate_product = create(
      :product,
      item_description_similarity: 1.0,
      brand_similarity: 0.0,
      item_pack_name: 'fake',
      item_measure: 'fake',
      item_sell_pack_name: 'fake',
      median_price: 0,
      item_size: 0,
      item_sell_quantity: 0
    )
    create(:product_duplicate,
      product: product,
      certainty_percentage: 1.00,
      potential_duplicate_product: potential_duplicate_product
    )
    assert_equal(0.85, product.reload.calculate_canonical_certainty)
  end

  test 'calculating certainty of being canonical when the catalogue usage is below the threshold' do
    product = create(:product, catalogue_count: 5)
    potential_duplicate_product = create(
      :product,
      item_description_similarity: 1.0,
      brand_similarity: 0.0,
      item_pack_name: 'fake',
      item_measure: 'fake',
      item_sell_pack_name: 'fake',
      median_price: 0,
      item_size: 0,
      item_sell_quantity: 0,
      catalogue_count: 10
    )
    create(:product_duplicate,
      product: product,
      certainty_percentage: 1.00,
      potential_duplicate_product: potential_duplicate_product
    )
    assert_equal(0.85, product.reload.calculate_canonical_certainty)
  end

  test 'calculating certainty of being canonical when the transaction usage is below the threshold' do
    product = create(:product, invoice_line_items_count: 5)
    potential_duplicate_product = create(
      :product,
      item_description_similarity: 1.0,
      brand_similarity: 0.0,
      item_pack_name: 'fake',
      item_measure: 'fake',
      item_sell_pack_name: 'fake',
      median_price: 0,
      item_size: 0,
      item_sell_quantity: 0,
      invoice_line_items_count: 10
    )
    create(:product_duplicate,
      product: product,
      certainty_percentage: 1.00,
      potential_duplicate_product: potential_duplicate_product
    )
    assert_equal(0.85, product.reload.calculate_canonical_certainty)
  end

  test 'calculating certainty of being canonical when the settings usage is below the threshold' do
    product = create(:product, procurement_products_count: 5)
    potential_duplicate_product = create(
      :product,
      item_description_similarity: 1.0,
      brand_similarity: 0.0,
      item_pack_name: 'fake',
      item_measure: 'fake',
      item_sell_pack_name: 'fake',
      median_price: 0,
      item_size: 0,
      item_sell_quantity: 0,
      procurement_products_count: 10
    )
    create(:product_duplicate,
      product: product,
      certainty_percentage: 1.00,
      potential_duplicate_product: potential_duplicate_product
    )
    assert_equal(0.85, product.reload.calculate_canonical_certainty)
  end

  test 'calculating certainty of being canonical when there are insufficient prices' do
    product = create(:product, price_count: 5)
    potential_duplicate_product = create(
      :product,
      item_description_similarity: 1.0,
      brand_similarity: 0.0,
      item_pack_name: 'fake',
      item_measure: 'fake',
      item_sell_pack_name: 'fake',
      median_price: 0,
      item_size: 0,
      item_sell_quantity: 0,
      price_count: 10
    )
    create(:product_duplicate,
      product: product,
      certainty_percentage: 1.00,
      potential_duplicate_product: potential_duplicate_product
    )
    assert_equal(0.85, product.reload.calculate_canonical_certainty)
  end

  test 'calculating certainty of being canonical when there are multiple red flags' do
    product = create(:product, image_file_name: nil, procurement_products_count: 5, price_count: 5)
    create(:product_issue,
      type: 'ProductIssues::MissingCompulsory',
      product: product,
      test_attribute: :item_description
    )
    potential_duplicate_product = create(
      :product,
      item_description_similarity: 1.0,
      brand_similarity: 0.0,
      item_pack_name: 'fake',
      item_measure: 'fake',
      item_sell_pack_name: 'fake',
      median_price: 0,
      item_size: 0,
      item_sell_quantity: 0,
      procurement_products_count: 3,
      price_count: 15
    )
    create(:product_duplicate,
      product: product,
      certainty_percentage: 1.00,
      potential_duplicate_product: potential_duplicate_product
    )
    assert_equal(0.55, product.reload.calculate_canonical_certainty)
  end
end
