# frozen_string_literal: true

module Modal
  class Component < ViewComponent::Base
    include Turbo::FramesHelper
    include IconsHelper

    renders_one :confirmation, lambda { |**args|
      Modal::ConfirmationComponent.new(name: @name, **args)
    }
    renders_one :form
    renders_many :buttons, Button::Component

    attr_reader :name, :hidden

    def initialize(name:, hidden: true)
      super
      @name = name
      @hidden = hidden
    end
  end
end
