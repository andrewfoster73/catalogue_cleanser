# frozen_string_literal: true

module Notification
  class Component < ViewComponent::Base
    include IconsHelper

    attr_reader :name, :type, :message, :hidden

    def initialize(name:, type:, message:, hidden: true)
      super
      @name = name
      @type = type
      @message = message
      @hidden = hidden
    end

    def title
      type.titleize
    end

    def icon_options
      case type
      when 'success'
        { name: :check_circle, colour: :emerald }
      when 'warning'
        { name: :exclamation, colour: :amber }
      when 'error'
        { name: :x_circle, colour: :rose }
      else
        { name: :information_circle, colour: :sky }
      end
    end
  end
end
