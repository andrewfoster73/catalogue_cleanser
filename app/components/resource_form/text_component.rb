# frozen_string_literal: true

module ResourceForm
  class TextComponent < BaseComponent
    def data_actions
      %w[
        keydown->editor#save
        keydown->editor#cancel
        focus->resource-form--component#selectAll
        keydown->resource-form--component#change
      ]
    end
  end
end
