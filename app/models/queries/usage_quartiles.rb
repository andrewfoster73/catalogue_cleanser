# frozen_string_literal: true

module Queries
  class UsageQuartiles < Base
    def call(options: {})
      @scope
        .select(
          "PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY #{options[:attributes].join('+')}) AS low," \
          "PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY #{options[:attributes].join('+')}) AS medium," \
          "PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY #{options[:attributes].join('+')}) AS high"
        )
        .find_by(
          "(#{options[:attributes].join('+')}) > 0"
        )
    end
  end
end
