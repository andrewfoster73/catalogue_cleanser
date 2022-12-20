# frozen_string_literal: true

module Queries
  class TasksCompletedByDay < Base
    class << self
      def to_h(scope: nil, options: {})
        call(scope: scope, options: options).each_with_object({}) do |result, hash|
          hash[result.completion_date] = result.count
        end
      end
    end

    def initialize(scope:)
      super
      @scope = scope || Task.all
    end

    def call(*)
      @scope
        .complete
        .select("to_char(updated_at, 'YYYY-MM-DD') AS completion_date, COUNT(id) AS count")
        .group("to_char(updated_at, 'YYYY-MM-DD')")
    end
  end
end
