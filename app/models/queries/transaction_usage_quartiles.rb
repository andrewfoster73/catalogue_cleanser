# frozen_string_literal: true

module Queries
  class TransactionUsageQuartiles < Base
    def initialize(scope: nil)
      super(scope: scope || Product.all)
    end

    def call(*)
      @scope
        .select(
          "PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY #{sum_of_transactions}) AS low," \
          "PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY #{sum_of_transactions}) AS medium," \
          "PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY #{sum_of_transactions}) AS high"
        )
        .find_by(
          "(#{sum_of_transactions}) > 0"
        )
    end

    def sum_of_transactions
      'invoice_line_items_count + requisition_line_items_count + purchase_order_line_items_count + ' \
      'receiving_document_line_items_count + inventory_internal_requisition_lines_count + ' \
      'inventory_transfer_items_count + inventory_stock_counts_count + point_of_sale_lines_count'
    end
  end
end
