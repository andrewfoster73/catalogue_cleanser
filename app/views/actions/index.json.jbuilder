# frozen_string_literal: true

json.array!(@actions, partial: 'actions/action', as: :action)
