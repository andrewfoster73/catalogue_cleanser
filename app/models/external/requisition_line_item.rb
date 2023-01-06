# frozen_string_literal: true

module External
  # Connects to External RequisitionLineItem class
  class RequisitionLineItem < External::ApplicationRecord
    self.table_name = :requisition_line_items

    belongs_to :external_product,
               class_name: 'External::Product', foreign_key: :product_id, inverse_of: :requisition_line_items
  end
end
