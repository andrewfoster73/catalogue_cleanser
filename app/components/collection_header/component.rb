# frozen_string_literal: true

module CollectionHeader
  class Component < ViewComponent::Base
    attr_reader :columns

    def initialize(columns:)
      super
      @columns = columns
    end

    def column_count
      # +1 for the actions column
      @columns.count + 1
    end
  end
end
