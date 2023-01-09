# frozen_string_literal: true

module Queries
  class ProductIssuesByType < Base
    class << self
      def to_h(scope: nil, options: {})
        ProductIssue.statuses.keys.each_with_object([]) do |status, array|
          data = call(scope: scope, options: options.map).where(status: status).map do |result|
            [result.type.safe_constantize.model_name.human, result.count]
          end
          array << {
            name: status, data: data || []
          }
        end
      end
    end

    def initialize(scope:)
      super
      @scope = scope || ProductIssue.all
    end

    def call(*)
      @scope
        .select('type, status, COUNT(id) AS count')
        .group(:status, :type)
    end
  end
end
