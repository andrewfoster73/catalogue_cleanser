# frozen_string_literal: true

module Tasks
  class GatherPricingStatistics < Task
    def initialize(attributes = nil)
      super
      self.description = 'Gather product pricing statistics from catalogues in P+'
    end

    protected

    def execute
      Audited.audit_class.as_user(task_id) do
        Rails.logger.info("GatherPricingStatistics (catalogue): started at #{Time.zone.now}")
        External::ProductPricingStatistics.create_temporary_table(prefix: task_id)
        Rails.logger.info("GatherPricingStatistics (catalogue): temporary table created at #{Time.zone.now}")
        External::ProductPricingStatistics
          .from_temporary_table(prefix: task_id)
          .for_country('AU')
          .find_each(batch_size: 10_000) { |record| update_pricing_statistics(record) }
        Rails.logger.info("GatherPricingStatistics (catalogue): update completed at #{Time.zone.now}")
        External::ProductPricingStatistics.drop_temporary_table(prefix: task_id)
      end
    end

    private

    def task_id
      "task-gather-pricing-statistics-#{id}"
    end

    # rubocop:disable Rails/SkipsModelValidations
    def update_pricing_statistics(record)
      # Using update_columns here because the better performance is required
      record.product&.update_columns(
        price_count: record.price_count,
        minimum_price: record.minimum_price,
        maximum_price: record.maximum_price,
        average_price: record.average_price,
        median_price: record.median_price,
        standard_deviation: record.standard_deviation,
        price_country: record.catalogue_owner_country,
        collected_pricing_at: Time.zone.now
      )
    end
    # rubocop:enable Rails/SkipsModelValidations
  end
end
