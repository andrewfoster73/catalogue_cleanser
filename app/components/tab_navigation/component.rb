# frozen_string_literal: true

module TabNavigation
  class Component < ViewComponent::Base
    renders_many :tabs, Tab::Component

    attr_accessor :id

    def initialize(id:)
      super
      @id = id
    end
  end
end
