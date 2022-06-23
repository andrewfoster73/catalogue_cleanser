# frozen_string_literal: true

module CollectionHeader
  class Component < ViewComponent::Base
    attr_reader :columns

    def initialize(columns:)
      super
      @columns = columns
    end

    def default_classes
      %w[
        sticky top-0 z-10 border-b border-gray-300 bg-gray-50 bg-opacity-75 px-3 py-3.5 text-left text-sm
        font-semibold text-gray-900 backdrop-blur backdrop-filter
      ]
    end
  end
end
