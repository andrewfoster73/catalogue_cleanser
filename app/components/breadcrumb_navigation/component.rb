# frozen_string_literal: true

module BreadcrumbNavigation
  class Component < ViewComponent::Base
    include Turbo::StreamsHelper

    renders_many :breadcrumbs, Breadcrumb::Component

    attr_reader :id

    def initialize(id:)
      super
      @id = id
    end
  end
end
