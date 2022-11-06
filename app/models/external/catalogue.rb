# frozen_string_literal: true

module External
  # Connects to external Goods::CataloguedProduct class
  class Catalogue < External::ApplicationRecord
    self.table_name = :catalogues

    has_many :catalogued_products, class_name: 'External::CataloguedProduct', dependent: :destroy
  end
end
