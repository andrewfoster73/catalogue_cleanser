# frozen_string_literal: true

module Calendar
  class Component < ViewComponent::Base
    include Turbo::FramesHelper
    include IconsHelper

    # @return [String] a unique identifier for setting the id on HTML elements in the component
    attr_reader :id
    # @return [Integer] the year to display
    attr_reader :year
    # @return [Integer] the month to display
    attr_reader :month
    # @return [String] the HTML id of the input connected to this calendar
    attr_reader :input_id
    # @return [Date] a string that has been parsed to a date representing the selected date in the attached input
    attr_reader :selected_date
    # @return [Boolean] true if the calendar is hidden, false otherwise
    attr_reader :hidden
    # @return [Date] the first day of the month and year for the calendar
    attr_reader :calendar_date
    # @return [Date] the current date in the current Time.zone
    attr_reader :today

    def initialize(id:, year:, month:, input_id:, selected_date: nil, hidden: true)
      super
      @id = id
      @year = Integer((year.presence || Time.zone.now.year.to_s), 10)
      @month = Integer((month.presence || Time.zone.now.month.to_s), 10)
      @input_id = input_id
      @selected_date = Date.parse(selected_date) if selected_date.present?
      @hidden = hidden
      @calendar_date = Date.new(@year, @month, 1)
      @today = Time.zone.now.to_date
    end

    # @return [Date] the first day of the previous calendar month
    def previous_month_date
      calendar_date - 1.month
    end

    # @return [Date] the first day of the next calendar month
    def next_month_date
      calendar_date + 1.month
    end

    # @return [Range] a six week date range starting from the first_day_of_range to last_day_of_range
    def six_week_date_range
      (first_day_of_range..last_day_of_range)
    end

    def first_day_of_range
      calendar_date.beginning_of_week
    end

    def last_day_of_range
      first_day_of_range + 41.days
    end

    def button_style(cell_date:, index:)
      [
        button_style_default,
        button_text_colour(cell_date: cell_date),
        ('font-semibold' if cell_date == today || cell_date == selected_date),
        (cell_date.month == calendar_date.month ? 'bg-white' : 'bg-gray-50'),
        corner_style(index: index)
      ].compact.join(' ')
    end

    def button_text_colour(cell_date:)
      return 'text-white' if cell_date == selected_date
      return 'text-sky-600' if cell_date == today
      return 'text-gray-900' if cell_date.month == calendar_date.month

      'text-gray-400'
    end

    def button_style_default
      'py-1.5 hover:bg-gray-100 focus:z-10'
    end

    def corner_style(index:)
      case index
      when 0
        'rounded-tl-lg'
      when 6
        'rounded-tr-lg'
      when 35
        'rounded-bl-lg'
      when 41
        'rounded-br-lg'
      else
        ''
      end
    end

    def day_style(cell_date:)
      [day_style_default, selected_date_style(cell_date: cell_date)].compact.join(' ')
    end

    def day_style_default
      'mx-auto flex h-5 w-5 items-center justify-center rounded-full'
    end

    def selected_date_style(cell_date:)
      return 'bg-gray-900' if cell_date == selected_date
    end
  end
end
