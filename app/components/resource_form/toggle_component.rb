# frozen_string_literal: true

module ResourceForm
  class ToggleComponent < BaseComponent
    def toggle_id
      "#{resource.model_name.singular}_#{resource.id || 'new'}_toggle_#{attribute}"
    end
  end
end
