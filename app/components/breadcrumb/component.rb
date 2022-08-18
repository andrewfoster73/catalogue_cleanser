# frozen_string_literal: true

module Breadcrumb
  class Component < ViewComponent::Base
    attr_accessor :id, :label, :url, :active

    def initialize(id:, label:, url:, active: false)
      super
      @id = id
      @label = label
      @url = url
      @active = active
    end

    def active_classes
      active ? 'font-bold text-sky-500 hover:text-sky-700' : 'font-medium text-gray-500 hover:text-gray-700'
    end
  end
end
