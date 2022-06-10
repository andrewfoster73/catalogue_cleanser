# frozen_string_literal: true

json.array!(@collection, partial: 'product_duplicates/product_duplicate', as: :product_duplicate)
