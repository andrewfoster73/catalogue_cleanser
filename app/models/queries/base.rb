# frozen_string_literal: true

module Queries
  class Base
    class << self
      def call(scope: nil, options: {})
        new(scope: scope).call(options: options)
      end
    end

    def initialize(scope: nil)
      @scope = scope
    end
  end
end
