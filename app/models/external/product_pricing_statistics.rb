# frozen_string_literal: true

module External
  # Connects to external view
  class ProductPricingStatistics < External::ApplicationRecord
    self.table_name = :vw_product_pricing_statistics
    self.primary_key = :id

    belongs_to :external_product, class_name: 'External::Product', foreign_key: :id,
                                  inverse_of: :product_pricing_statistics
    delegate :product, to: :external_product, allow_nil: true

    class << self
      def create_temporary_table(prefix:)
        connection.create_table("#{prefix}_product_pricing_statistics",
                                temporary: true, as: 'SELECT * FROM vw_product_pricing_statistics'
        )
      end

      def drop_temporary_table(prefix:)
        connection.drop_table("#{prefix}_product_pricing_statistics", if_exists: true)
      end

      def from_temporary_table(prefix:)
        Class.new(ApplicationRecord) do
          self.table_name = "#{prefix}_product_pricing_statistics"
          belongs_to :external_product, class_name: '::External::Product', foreign_key: :id,
                                        inverse_of: :product_pricing_statistics
          delegate :product, to: :external_product, allow_nil: true

          scope :for_country, -> (country) { where(catalogue_owner_country: country) }
        end.all
      end
    end
  end
end
