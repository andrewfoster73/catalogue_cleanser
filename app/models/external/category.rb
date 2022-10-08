# frozen_string_literal: true

module External
  # Connects to external Goods::Category class
  class Category < External::ApplicationRecord
    self.table_name = :goods_categories
  end
end
