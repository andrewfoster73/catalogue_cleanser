# frozen_string_literal: true

module Tasks
  class GatherUsageStatistics < Task
    def initialize(attributes = nil)
      super
      self.description = 'Gather product usage statistics from transactions and lists in P+'
    end

    protected

    def execute
      Audited.audit_class.as_user(task_id) do
        External::ProductUsageCount.create_temporary_table(prefix: task_id)
        External::ProductUsageCount
          .from_temporary_table(prefix: task_id)
          .find_each(batch_size: 10_000) { |record| update_counts(record) }
        External::ProductUsageCount.drop_temporary_table(prefix: task_id)
      end
    end

    private

    def task_id
      "task-gather-usage-statistics-#{id}"
    end

    # rubocop:disable Rails/SkipsModelValidations
    def update_counts(record)
      Rails.logger.warn("No external product: #{record.id}") unless record.external_product
      # Using update_columns here because the better performance is required
      record.product&.update_columns(
        invoice_line_items_count: record.invoice_line_items_count,
        requisition_line_items_count: record.requisition_line_items_count,
        inventory_internal_requisition_lines_count: record.inventory_internal_requisition_lines_count,
        purchase_order_line_items_count: record.purchase_order_line_items_count,
        receiving_document_line_items_count: record.receiving_document_line_items_count,
        point_of_sale_lines_count: record.point_of_sale_lines_count,
        inventory_transfer_items_count: record.inventory_transfer_items_count,
        catalogue_count: record.catalogue_count,
        buy_list_count: record.buy_list_count,
        priced_catalogue_count: record.priced_catalogue_count,
        inventory_barcodes_count: record.inventory_barcodes_count,
        inventory_derived_period_balances_count: record.inventory_derived_period_balances_count,
        inventory_stock_counts_count: record.inventory_stock_counts_count,
        inventory_stock_levels_count: record.inventory_stock_levels_count,
        procurement_products_count: record.procurement_products_count,
        product_supplier_preferences_count: record.product_supplier_preferences_count,
        rebates_profile_products_count: record.rebates_profile_products_count,
        recipes_count: record.recipes_count,
        collected_statistics_at: Time.zone.now
      )
    end
    # rubocop:enable Rails/SkipsModelValidations
  end
end
