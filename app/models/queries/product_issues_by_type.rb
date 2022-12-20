# frozen_string_literal: true

module Queries
  class ProductIssuesByType < Base
    class << self
      def to_h(scope: nil, options: {})
        call(scope: scope, options: options).each_with_object({}) do |result, hash|
          hash[result.type.safe_constantize.model_name.human] = result.count
        end
      end
    end

    def initialize(scope:)
      super
      @scope = scope || ProductIssue.all
    end

    def call(*)
      @scope
        .select('type, COUNT(id) AS count')
        .group(:type)
    end
  end
end
