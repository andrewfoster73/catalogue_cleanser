# frozen_string_literal: true

module ResourceForm
  class FieldComponent < ViewComponent::Base
    include ViewComponent::PolymorphicSlots
    include IconsHelper

    renders_one :attribute, types: {
      text: ResourceForm::TextComponent,
      toggle: ResourceForm::ToggleComponent,
      timestamp: ResourceForm::TimestampComponent
    }
  end
end
