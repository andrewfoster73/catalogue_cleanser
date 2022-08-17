# frozen_string_literal: true

module BreadcrumbNavigation
  class ComponentStories < ApplicationStories
    story :item_sell_packs do
      constructor(id: :breadcrumb_navigation)
      breadcrumb(id: :item_sell_packs, label: text('Item Sell Packs'), url: '#item_sell_packs')
      breadcrumb(id: 'item_sell_pack_51', label: text('carton'), url: '#item_sell_pack_51', active: true)
    end
  end
end
