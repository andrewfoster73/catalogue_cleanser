# frozen_string_literal: true

module CollectionPager
  class ComponentStories < ApplicationStories
    Paginator = Struct.new(:next, keyword_init: true)
    private_constant :Paginator

    story :item_sell_packs_next_page do
      constructor(paginator: Paginator.new(next: 2), collection_path_method: :item_sell_packs_path)
    end

    story :item_sell_packs_last_page do
      constructor(paginator: Paginator.new(next: nil), collection_path_method: :item_sell_packs_path)
    end
  end
end
