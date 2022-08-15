# frozen_string_literal: true

module CollectionFilter
  class Component < ViewComponent::Base
    include Ransack::Helpers::FormHelper

    attr_reader :filter, :url

    def initialize(filter:, url: nil)
      super
      @filter = filter
      @url = url
    end
  end
end
