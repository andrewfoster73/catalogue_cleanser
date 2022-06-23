# frozen_string_literal: true

module CollectionHeader
  class ComponentStories < ApplicationStories
    story :basic, Collection::Component do
      header(columns: [{ name: 'Title' }])
    end

    story :additional_classes, Collection::Component do
      header(columns: [{ name: 'Title', classes: 'text-right' }])
    end
  end
end
