# frozen_string_literal: true

module External
  # Connects to External RequisitionLineItem class
  class RequisitionLineItem < External::ApplicationRecord
    self.table_name = :requisition_line_items
  end
end
