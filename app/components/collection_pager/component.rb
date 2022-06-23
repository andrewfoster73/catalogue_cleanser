# frozen_string_literal: true

module CollectionPager
  class Component < ViewComponent::Base
    attr_reader :paginator, :collection_path_method, :filter_params

    def initialize(paginator:, collection_path_method:, filter_params: nil)
      super
      @paginator = paginator
      @collection_path_method = collection_path_method
      @filter_params = filter_params
    end
  end
end
