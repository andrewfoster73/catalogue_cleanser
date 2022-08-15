# frozen_string_literal: true

module Button
  class DeleteResourceComponent < Button::ResourceComponent
    def initialize(id:, label: 'Delete', options: {})
      super
    end

    private

    def default_options
      {
        icon: { name: :trash, colour: :white },
        colour_classes: 'text-white bg-rose-500 hover:bg-rose-600 focus:ring-rose-200',
        data: {
          action: 'click->resource#confirmDelete'
        }
      }
    end
  end
end