# frozen_string_literal: true

module Button
  class DeleteResourceComponent < Button::ResourceComponent
    private

    def label
      t('button.delete_resource_component.labels.delete')
    end

    def default_options
      super.merge(
        {
          icon: { name: :trash, colour: :white },
          colour_classes: 'text-white bg-rose-500 hover:bg-rose-600 focus:ring-rose-200',
          data: {
            action: 'click->resource#confirmDelete'
          }
        }
      )
    end
  end
end
