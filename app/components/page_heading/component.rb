# frozen_string_literal: true

module PageHeading
  class Component < ViewComponent::Base
    attr_reader :title, :description

    renders_one :actions
    renders_one :details

    def initialize(title:, description: '')
      super
      @title = title
      @description = description
    end
  end
end
