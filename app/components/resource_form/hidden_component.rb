# frozen_string_literal: true

module ResourceForm
  class HiddenComponent < BaseComponent
    attr_reader :value

    def initialize(attribute:, label:, resource:, options: nil)
      super
      @value = options[:value]
    end
  end
end
