# frozen_string_literal: true

module CollectionFilter
  class ContainsComponentStories < ApplicationStories
    story :basic do
      constructor(label: 'Name contains', attribute: :name)
    end
  end
end
