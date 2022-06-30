# frozen_string_literal: true

module PageHeading
  class ComponentStories < ApplicationStories
    story :item_sell_packs do
      constructor(title: 'Item Sell Packs',
                  description: 'These are the names for how a supplier sells a complete package'
                 )

      actions do
        link_to 'New item sell pack', new_item_sell_pack_path,
                class: 'inline-flex items-center justify-center rounded-md border border-transparent bg-sky-600 ' \
                       'px-4 py-2 text-sm font-medium text-white shadow-sm hover:bg-sky-700 focus:outline-none ' \
                       'focus:ring-2 focus:ring-sky-500 focus:ring-offset-2 sm:w-auto'
      end
    end
  end
end
