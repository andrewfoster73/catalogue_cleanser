# frozen_string_literal: true

module External
  # Connects to external view
  class ProductTransactionUsageCount < External::ApplicationRecord
    self.table_name = :vw_product_transaction_usage_counts
    self.primary_key = :id

    belongs_to :external_product, class_name: 'External::Product', foreign_key: :id,
                                  inverse_of: :product_transaction_usage_count
    delegate :product, to: :external_product, allow_nil: true

    class << self
      def create_temporary_table(prefix:)
        connection.create_table("#{prefix}_product_transaction_usage_counts",
                                temporary: true, as: 'SELECT * FROM vw_product_transaction_usage_counts'
        )
      end

      def drop_temporary_table(prefix:)
        connection.drop_table("#{prefix}_product_transaction_usage_counts", if_exists: true)
      end

      def from_temporary_table(prefix:)
        Class.new(ApplicationRecord) do
          self.table_name = "#{prefix}_product_transaction_usage_counts"
          belongs_to :external_product, class_name: '::External::Product', foreign_key: :id,
                                        inverse_of: :product_transaction_usage_count
          delegate :product, to: :external_product, allow_nil: true
        end.all
      end
    end
  end
end
