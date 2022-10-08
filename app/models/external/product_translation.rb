# frozen_string_literal: true

module External
  # Connects to External Goods::ProductTranslation class
  class ProductTranslation < External::ApplicationRecord
    self.table_name = :goods_product_translations

    belongs_to :external_product, class_name: 'External::Product', foreign_key: :product_id,
                                  inverse_of: :translations
  end
end
