# frozen_string_literal: true

module CollectionFilter
  class DateRangeComponentStories < ApplicationStories
    story :basic do
      constructor(attribute: :created_at)
    end
  end
end
