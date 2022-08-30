# frozen_string_literal: true

module CollectionFilter
  class ElementComponent < ViewComponent::Base
    renders_one :component, types: {
      contains: ContainsComponent,
      toggle: ToggleComponent,
      date_range: DateRangeComponent,
      list: ListComponent
    }
  end
end
