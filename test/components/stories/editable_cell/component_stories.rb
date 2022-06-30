# frozen_string_literal: true

module EditableCell
  class ComponentStories < ApplicationStories
    story :basic do
      constructor(
        url: '/item_sell_packs/1/edit',
        resource: klazz(ItemSellPack, name: text('carton'), canonical: true),
        attribute: :name,
        formatter: text('string')
      )
    end
  end
end
