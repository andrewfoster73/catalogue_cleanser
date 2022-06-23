# frozen_string_literal: true

module Collection
  class ComponentStories < ApplicationStories
    Paginator = Struct.new(:next, keyword_init: true)
    private_constant :Paginator

    story :no_rows do
      header(columns: [{ name: 'Title' }])
      pager(paginator: Paginator.new(next: nil), collection_path_method: :item_sell_packs_path)
    end
  end
end
