# frozen_string_literal: true

module CollectionFilter
  class Component < ViewComponent::Base
    include IconsHelper

    renders_many :elements, CollectionFilter::ElementComponent

    attr_reader :filter, :url

    def initialize(filter:, url: nil)
      super
      @filter = filter
      @url = url
    end

    private

    def form_id
      "#{filter.klass.model_name.singular}_search"
    end
  end
end
