# frozen_string_literal: true

module CollectionRows
  class Component < ViewComponent::Base
    renders_many :rows, CollectionRow::Component
  end
end
