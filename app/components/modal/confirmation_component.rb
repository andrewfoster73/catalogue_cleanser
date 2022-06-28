# frozen_string_literal: true

module Modal
  class ConfirmationComponent < ViewComponent::Base
    include IconsHelper

    attr_reader :name, :icon_options, :title, :message

    def initialize(name:, icon_options:, title:, message: '')
      super
      @name = name
      @icon_options = icon_options
      @title = title
      @message = message
    end
  end
end
