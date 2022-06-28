# frozen_string_literal: true

module CollectionRow
  class Component < ViewComponent::Base
    renders_one :body

    attr_reader :id

    def initialize(id:)
      super
      @id = id
    end
  end
end
