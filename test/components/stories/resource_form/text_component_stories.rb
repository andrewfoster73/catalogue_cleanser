# frozen_string_literal: true

module ResourceForm
  class TextComponentStories < ApplicationStories
    story :basic do
      constructor(
        attribute: text('name'),
        label: text('Name'),
        resource: klazz(ItemSellPack, name: text('carton'), canonical: true),
        readonly: boolean(false)
      )
    end
  end
end
