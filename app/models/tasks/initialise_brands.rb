# frozen_string_literal: true

module Tasks
  class InitialiseBrands < Task
    def initialize(attributes = nil)
      super
      self.description = 'Initialise the Brands using the contents of the brand attribute on ' \
                         'the P+ master catalogue.'
    end

    protected

    def execute
      names.each do |name|
        next if name.blank?

        Brand.find_or_create_by!(
          name: name.squeeze,
          canonical: true,
          data_source: :import
        )
      end
    end

    private

    def names
      External::Product
        .select('TRIM(brand) AS brand')
        .managed
        .where("brand IS NOT NULL and TRIM(brand) != ''")
        .distinct
        .map(&:brand)
    end
  end
end
