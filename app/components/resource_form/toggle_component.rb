# frozen_string_literal: true

module ResourceForm
  class ToggleComponent < BaseComponent
    def toggle_id
      "toggle_#{attribute}"
    end
  end
end
