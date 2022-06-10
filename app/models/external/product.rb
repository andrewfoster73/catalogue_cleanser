# frozen_string_literal: true

module External
  # Connects to External Goods::Product class
  class Product < External::ApplicationRecord
    self.table_name = :goods_products

    MASTER_CATALOGUE_ID = 1
    private_constant :MASTER_CATALOGUE_ID

    has_many :catalogued_products, class_name: 'External::CataloguedProduct', dependent: :destroy

    # Belong to the "master" or "central" catalogue managed by Marketboomer
    scope :managed, lambda {
      joins(:catalogued_products).where(goods_catalogued_products: { catalogue_id: MASTER_CATALOGUE_ID })
    }
    scope :distinct_attribute, -> (attribute) { managed.select("DISTINCT(#{attribute})") }
  end
end
