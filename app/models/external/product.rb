# frozen_string_literal: true

module External
  # Connects to External Goods::Product class
  class Product < External::ApplicationRecord
    self.table_name = :goods_products

    include ProductConcatenations

    MASTER_CATALOGUE_ID = 1
    private_constant :MASTER_CATALOGUE_ID

    belongs_to :category, class_name: 'External::Category', optional: true
    has_one :product, class_name: '::Product', dependent: nil, foreign_key: :external_product_id,
                      inverse_of: :external_product
    has_one :product_usage_count, class_name: 'External::ProductUsageCount', dependent: nil, foreign_key: :id,
                                  inverse_of: :external_product
    has_many :catalogued_products, class_name: 'External::CataloguedProduct', dependent: :destroy
    has_many :translations, class_name: 'External::ProductTranslation', dependent: :destroy
    has_many :requisition_line_items, class_name: 'External::RequisitionLineItem', dependent: nil

    # Belong to the "master" or "central" catalogue managed by Marketboomer
    scope :managed, lambda {
      joins(:catalogued_products).where(goods_catalogued_products: { catalogue_id: MASTER_CATALOGUE_ID })
    }
    scope :distinct_attribute, -> (attribute) { managed.select("DISTINCT(#{attribute})") }

    private

    def set_search_text
      (translations.reject { |t| t.locale == locale }.map(&:_search_text) << _search_text).compact.join(' ')
    end
  end
end
