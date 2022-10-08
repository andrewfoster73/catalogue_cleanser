# frozen_string_literal: true

module External
  # Connects to external Goods::CataloguedProduct class
  class Catalogue < External::ApplicationRecord
    self.table_name = :catalogues
  end
end
