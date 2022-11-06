# frozen_string_literal: true

module External
  # Connects to external view
  class ProductUsageCount < External::ApplicationRecord
    self.table_name = :vw_product_usage_counts
    self.primary_key = :id

    belongs_to :product, class_name: '::Product', foreign_key: :id, inverse_of: :external_product_usage_counts

    class << self
      def create_temporary_table(prefix:)
        connection.create_table("#{prefix}_product_usage_counts", temporary: true,
                                                                  as: 'SELECT * FROM vw_product_usage_counts'
        )
      end

      def drop_temporary_table(prefix:)
        connection.drop_table("#{prefix}_product_usage_counts", if_exists: true)
      end

      def from_temporary_table(prefix:)
        Class.new(ApplicationRecord) do
          self.table_name = "#{prefix}_product_usage_counts"
          belongs_to :product, class_name: '::Product', foreign_key: :id, inverse_of: :external_product_usage_counts
        end.all
      end
    end
  end
end
