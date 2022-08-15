# frozen_string_literal: true

module Button
  class ViewResourceComponent < Button::ResourceComponent
    private

    def label
      'View'
    end

    def default_options
      {
        icon: { name: :eye, colour: :white },
        colour_classes: 'text-white bg-sky-600 hover:bg-sky-700 focus:ring-sky-200',
        data: {
          action: 'click->resource#navigate'
        }
      }
    end
  end
end
