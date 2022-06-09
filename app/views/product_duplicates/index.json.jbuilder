# frozen_string_literal: true

json.array!(@product_duplicates, partial: 'product_duplicates/product_duplicate', as: :product_duplicate)
