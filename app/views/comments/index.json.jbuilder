# frozen_string_literal: true

json.array!(@collection, partial: 'comments/comment', as: :comment)
