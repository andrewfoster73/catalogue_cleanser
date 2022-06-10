# frozen_string_literal: true

json.array!(@collection, partial: 'item_measures/item_measure', as: :item_measure)
