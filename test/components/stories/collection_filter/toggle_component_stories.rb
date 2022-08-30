# frozen_string_literal: true

module CollectionFilter
  class ToggleComponentStories < ApplicationStories
    story :basic do
      constructor(label: 'Canonical', attribute: :canonical)
    end
  end
end
