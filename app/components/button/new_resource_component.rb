# frozen_string_literal: true

module Button
  class NewResourceComponent < Button::Component
    def initialize(id:, label: 'New', options: {})
      super
      @options = default_options.deep_merge(options)
    end

    private

    def default_options
      {
        icon: { name: :plus, colour: :white },
        colour_classes: 'text-white bg-emerald-600 hover:bg-emerald-700 focus:ring-emerald-200',
        data: {
          action: 'click->resource#new',
          params: [
            { name: 'resource-modal-name', value: id }
          ]
        }
      }
    end
  end
end
