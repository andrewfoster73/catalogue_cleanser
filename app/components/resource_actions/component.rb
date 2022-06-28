# frozen_string_literal: true

module ResourceActions
  class Component < ViewComponent::Base
    renders_many :buttons, Button::Component
  end
end
