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
        gather_usage(source: External::ProductCatalogueUsageCount, update_method: :update_catalogue_counts)
        gather_usage(source: External::ProductSettingsUsageCount, update_method: :update_settings_counts)
        gather_usage(source: External::ProductTransactionUsageCount, update_method: :update_transaction_counts)
      end
    end

    private

    def task_id
      "task-gather-usage-statistics-#{id}"
    end

    def gather_usage(source:, update_method:)
      Rails.logger.info("GatherUsageStatistics (#{source.name}): started at #{Time.zone.now}")
      source.create_temporary_table(prefix: task_id)
      Rails.logger.info("GatherUsageStatistics (#{source.name}): temporary table created at #{Time.zone.now}")
      source
        .from_temporary_table(prefix: task_id)
        .find_each(batch_size: 10_000) { |record| send(update_method, record) }
      Rails.logger.info("GatherUsageStatistics (#{source.name}): update completed at #{Time.zone.now}")
      source.drop_temporary_table(prefix: task_id)
    end

    # rubocop:disable Rails/SkipsModelValidations
    def update_transaction_counts(record)
      Rails.logger.warn("No external product: #{record.id}") unless record.external_product
      # Using update_columns here because the better performance is required
      record.product&.update_columns(
        invoice_line_items_count: record.invoice_line_items_count,
        credit_note_lines_count: record.credit_note_lines_count,
        requisition_line_items_count: record.requisition_line_items_count,
        inventory_internal_requisition_lines_count: record.inventory_internal_requisition_lines_count,
        purchase_order_line_items_count: record.purchase_order_line_items_count,
        receiving_document_line_items_count: record.receiving_document_line_items_count,
        point_of_sale_lines_count: record.point_of_sale_lines_count,
        inventory_transfer_items_count: record.inventory_transfer_items_count,
        inventory_stock_counts_count: record.inventory_stock_counts_count,
        collected_usage_at: Time.zone.now
      )
    end

    def update_catalogue_counts(record)
      Rails.logger.warn("No external product: #{record.id}") unless record.external_product
      # Using update_columns here because the better performance is required
      record.product&.update_columns(
        catalogue_count: record.catalogue_count,
        buy_list_count: record.buy_list_count,
        priced_catalogue_count: record.priced_catalogue_count,
        inventory_derived_period_balances_count: record.inventory_derived_period_balances_count,
        inventory_stock_levels_count: record.inventory_stock_levels_count,
        recipes_count: record.recipes_count,
        collected_usage_at: Time.zone.now
      )
    end

    def update_settings_counts(record)
      Rails.logger.warn("No external product: #{record.id}") unless record.external_product
      # Using update_columns here because the better performance is required
      record.product&.update_columns(
        inventory_barcodes_count: record.inventory_barcodes_count,
        procurement_products_count: record.procurement_products_count,
        linked_products_count: record.linked_products_count,
        product_supplier_preferences_count: record.product_supplier_preferences_count,
        rebates_profile_products_count: record.rebates_profile_products_count,
        collected_usage_at: Time.zone.now
      )
    end
    # rubocop:enable Rails/SkipsModelValidations
  end
end
