# frozen_string_literal: true

module Tasks
  class GatherCertaintyStatistics < Task
    def initialize(attributes = nil)
      super
      self.description = 'Gather product canonical certainty and duplication certainty'
    end

    protected

    def execute
      Audited.audit_class.as_user(task_id) do
        Rails.logger.info("GatherCertaintyStatistics (catalogue): started at #{Time.zone.now}")
        Product.kept.find_each(batch_size: 10_000) { |record| update_certainty_statistics(record) }
        Rails.logger.info("GatherCertaintyStatistics (catalogue): update completed at #{Time.zone.now}")
      end
    end

    private

    def task_id
      "task-gather-certainty-statistics-#{id}"
    end

    # rubocop:disable Rails/SkipsModelValidations
    def update_certainty_statistics(record)
      # Using update_columns here because the better performance is required
      record.update_columns(
        duplication_certainty: record.calculate_duplication_certainty,
        canonical_certainty: record.calculate_canonical_certainty,
        collected_certainty_at: Time.zone.now
      )
    end
    # rubocop:enable Rails/SkipsModelValidations
  end
end
