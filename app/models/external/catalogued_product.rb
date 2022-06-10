# frozen_string_literal: true

module External
  # Connects to external Goods::CataloguedProduct class
  class CataloguedProduct < External::ApplicationRecord
    self.table_name = :goods_catalogued_products
  end
end
