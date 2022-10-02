# frozen_string_literal: true

module CollectionPager
  class Component < ViewComponent::Base
    attr_reader :paginator, :collection_path_method, :parent_param, :filter_params

    def initialize(paginator:, collection_path_method:, parent_param: nil, filter_params: nil)
      super
      @paginator = paginator
      @collection_path_method = collection_path_method
      @filter_params = filter_params
      @parent_param = parent_param
    end

    private

    def pager_url
      public_send(collection_path_method, parent_param, page: paginator.next, q: filter_params&.to_unsafe_h)
    end
  end
end
