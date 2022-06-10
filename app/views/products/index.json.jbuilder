# frozen_string_literal: true

json.array!(@collection, partial: 'products/product', as: :product)
