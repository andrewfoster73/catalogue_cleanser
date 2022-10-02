# frozen_string_literal: true

# Renders a Calendar::Component in a turbo frame
class CalendarController < ApplicationController
  include TurboFrameVariants

  # @param [Integer] :id the unique identifier for the calendar container
  # @param [Integer] :year the calendar year to display
  # @param [Integer] :month the calendar month to display, 1 for January up to 12 for December
  # @param [String] :input_id the HTML id of the input that should receive calendar selection updates
  # @param [String] :selected_date the date that is currently selected in YYYY-MM-DD format
  # @param [String] :max_date the maximum date that can be selected
  # @param [String] :min_date the minimum date that can be selected
  # @param [Boolean] :hidden true to add the hidden attribute to the calendar container
  # @example Calendar for Year 2022, Month July
  #    /calendar?id=created_at_from&input_id=q_created_at_gteq&year=2022&month=7
  def index; end
end
