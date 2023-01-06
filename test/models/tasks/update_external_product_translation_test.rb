# frozen_string_literal: true

require 'test_helper'

class Tasks::UpdateExternalProductTranslationTest < ActiveSupport::TestCase
  setup do
    @product_translation = product_translations(:lager)
    @master_catalogue = create(:external_catalogue)
    @external_catalogued_product = create(:external_catalogued_product,
                                          external_product: @product_translation.product.external_product
                                         )
  end

  test 'updates external product translation' do
    @product_translation.update!(item_description: 'Tasty Lager')
    @task = Tasks::UpdateExternalProductTranslation.create!(context: @product_translation)
    @task.call
    assert_equal('Tasty Lager', @product_translation.external_product_translation.reload.item_description)
  end

  test 'is executable if changed attributes are relevant' do
    @product_translation.update!(item_description: 'Tasty Lager')
    assert_equal(true, Tasks::UpdateExternalProductTranslation.executable?(@product_translation.previous_changes))
  end

  test 'is not executable if changed attributes are not relevant' do
    @product_translation.update!(data_source: 'manual')
    assert_equal(false, Tasks::UpdateExternalProductTranslation.executable?(@product_translation.previous_changes))
  end
end
