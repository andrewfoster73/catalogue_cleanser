# frozen_string_literal: true

module ResourceForm
  class ToggleComponentStories < ApplicationStories
    story :basic do
      constructor(
        attribute: text('canonical'),
        label: text('Canonical'),
        resource: klazz(ItemSellPack, name: 'carton', canonical: boolean(true)),
        options: object({ readonly: false, help: 'This is a help message' })
      )
    end
  end
end
