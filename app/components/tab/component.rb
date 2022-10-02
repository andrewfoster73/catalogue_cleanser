# frozen_string_literal: true

module Tab
  class Component < ViewComponent::Base
    include Turbo::StreamsHelper
    include IconsHelper

    attr_reader :id, :label, :url, :active, :options

    def initialize(id:, label:, url:, active: false, options: {})
      super
      @id = id
      @label = label
      @url = url
      @active = active
      @options = options
    end

    private

    def tab_id
      return id unless parent

      "#{parent.resource_name}_#{parent.id}_#{id}"
    end

    def tab_classes
      active ? 'text-gray-900 bg-sky-50' : 'bg-white text-gray-500 hover:text-gray-700'
    end

    def badge_classes
      active ? 'bg-gray-100 text-gray-900' : 'bg-sky-100 text-sky-600'
    end

    def icon_options
      options[:icon_options]
    end

    def parent
      options[:parent]
    end

    def badge_count
      options[:badge_count]
    end
  end
end
