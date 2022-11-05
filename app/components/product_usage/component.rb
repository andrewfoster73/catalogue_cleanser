# frozen_string_literal: true

module ProductUsage
  class Component < ViewComponent::Base
    attr_reader :resource

    def initialize(resource:)
      super
      @resource = resource
    end

    private

    def usage_badge_classes(ranking:)
      case ranking
      when 'low'
        'bg-green-100 text-green-800'
      when 'lowest'
        'bg-cyan-100 text-cyan-800'
      when 'medium'
        'bg-yellow-100 text-yellow-800'
      when 'high'
        'bg-red-100 text-red-800'
      else
        'bg-gray-100 text-gray-800'
      end
    end
  end
end
