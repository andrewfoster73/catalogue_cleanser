# frozen_string_literal: true

json.array!(@collection, partial: 'item_packs/item_pack', as: :item_pack)
