# frozen_string_literal: true

module Collection
  class Component < ViewComponent::Base
    renders_one :header, CollectionHeader::Component
    renders_one :rows, CollectionRows::Component
    renders_one :pager, CollectionPager::Component
  end
end
