# frozen_string_literal: true

module Button
  class Component < ViewComponent::Base
    include IconsHelper

    attr_reader :id, :label, :options

    def initialize(id:, label:, options: {})
      super
      @id = id
      @label = label
      @options = options
    end
  end
end
