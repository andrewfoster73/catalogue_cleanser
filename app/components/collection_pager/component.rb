# frozen_string_literal: true

module CollectionPager
  class Component < ViewComponent::Base
    attr_reader :paginator, :collection_path_method

    def initialize(paginator:, collection_path_method:)
      super
      @paginator = paginator
      @collection_path_method = collection_path_method
    end
  end
end
