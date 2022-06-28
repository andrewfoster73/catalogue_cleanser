# frozen_string_literal: true

module ResourceForm
  class ToggleComponentStories < ApplicationStories
    story :basic do
      constructor(
        attribute: text('canonical'),
        label: text('Canonical'),
        resource: klazz(ItemSellPack, name: 'carton', canonical: boolean(true)),
        readonly: boolean(false)
      )
    end
  end
end
