# frozen_string_literal: true

module External
  # Connects to external Goods::CataloguedProduct class
  class CataloguedProduct < External::ApplicationRecord
    self.table_name = :goods_catalogued_products

    belongs_to :catalogue, class_name: 'External::Catalogue', inverse_of: :catalogued_products
    belongs_to :external_product,
               class_name: 'External::Product', foreign_key: :product_id, inverse_of: :catalogued_products
  end
end
