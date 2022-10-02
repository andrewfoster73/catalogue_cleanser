# frozen_string_literal: true

module CollectionFilter
  # Two date fields representing a "from" and "to" date range to filter on
  # @todo Prevent from date > to date
  class DateRangeComponent < ViewComponent::Base
    include Turbo::FramesHelper

    # @return [Symbol] the name of the attribute to filter on
    attr_reader :attribute
    # @return [String] the start of the date range
    attr_reader :from_date
    # @return [String] the end of the date range
    attr_reader :to_date

    def initialize(attribute:, from_date: '', to_date: '')
      super
      @attribute = attribute
      @from_date = from_date
      @to_date = to_date
    end

    private

    def from_calendar_url
      "/calendar?id=#{attribute}_from&input_id=q_#{attribute}_gteq&selected_date=#{from_date}" \
      "&max_date=#{to_date}&hidden=true"
    end

    def to_calendar_url
      "/calendar?id=#{attribute}_to&input_id=q_#{attribute}_lteq&selected_date=#{to_date}" \
      "&min_date=#{from_date}&hidden=true"
    end
  end
end
