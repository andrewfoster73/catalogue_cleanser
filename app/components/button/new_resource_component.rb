# frozen_string_literal: true

module Button
  class NewResourceComponent < Button::ResourceComponent
    private

    def label
      t('button.new_resource_component.labels.new')
    end

    def default_options
      super.merge(
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
      )
    end
  end
end
