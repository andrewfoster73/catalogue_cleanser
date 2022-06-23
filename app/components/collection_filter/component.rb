# frozen_string_literal: true

module CollectionFilter
  class Component < ViewComponent::Base
    include Ransack::Helpers::FormHelper

    attr_reader :filter

    def initialize(filter:)
      super
      @filter = filter
    end
  end
end
