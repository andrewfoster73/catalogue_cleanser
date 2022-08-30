# frozen_string_literal: true

module CollectionFilter
  class ComponentStories < ApplicationStories
    story :empty do
      constructor(filter: ItemSellPack.ransack({}), url: nil)
    end
  end
end
