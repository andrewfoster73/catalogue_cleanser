# frozen_string_literal: true

module Button
  class ResourceComponent < Button::Component
    def initialize(id:, label: '', options: {})
      super
      @options = default_options.deep_merge(options)
    end

    private

    def default_options
      {}
    end
  end
end
