# frozen_string_literal: true

module CollectionFilter
  # Two date fields representing a "from" and "to" date range to filter on
  # @todo Prevent from date > to date
  class DateRangeComponent < ViewComponent::Base
    include Turbo::FramesHelper

    # @return [Symbol] the name of the attribute to filter on
    attr_reader :attribute

    def initialize(attribute:)
      super
      @attribute = attribute
    end

    def from_calendar_url
      "/calendar?id=#{attribute}_from&input_id=q_#{attribute}_gteq&selected_date=#{from_filter_value}&hidden=true"
    end

    def from_filter_value
      params.dig(:q, :"#{attribute}_gteq")
    end

    def to_calendar_url
      "/calendar?id=#{attribute}_to&input_id=q_#{attribute}_lteq&selected_date=#{to_filter_value}&hidden=true"
    end

    def to_filter_value
      params.dig(:q, :"#{attribute}_lteq")
    end
  end
end
