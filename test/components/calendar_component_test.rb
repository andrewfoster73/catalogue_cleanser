# frozen_string_literal: true

require 'test_helper'

class Calendar::ComponentTest < ViewComponent::TestCase
  test 'august 2022' do
    travel_to(Time.zone.local(2022, 8, 28)) do
      render_inline(
        Calendar::Component.new(
          id: :created_at_from,
          year: '2022',
          month: '8',
          input_id: :the_input_id,
          hidden: false
        )
      )

      assert_selector('a#created_at_from_calendar--previous_month_button[href="/calendar?id=created_at_from&input_id=the_input_id&year=2022&month=7"]')
      assert_selector('#created_at_from_calendar--current_year_month', text: 'August 2022')
      assert_selector('a#created_at_from_calendar--next_month_button[href="/calendar?id=created_at_from&input_id=the_input_id&year=2022&month=9"]')
    end
  end

  test 'current day highlighted' do
    travel_to(Time.zone.local(2023, 8, 21)) do
      render_inline(
        Calendar::Component.new(
          id: :created_at_from,
          year: '2023',
          month: '8',
          input_id: :the_input_id,
          hidden: false
        )
      )

      assert_selector('button#created_at_from_calendar--button_2023-08-21.text-sky-600.font-semibold')
      assert_selector('button#created_at_from_calendar--button_2023-08-22.text-gray-900')
    end
  end

  test 'selected day highlighted' do
    travel_to(Time.zone.local(2023, 8, 21)) do
      render_inline(
        Calendar::Component.new(
          id: :created_at_from,
          year: '2023',
          month: '8',
          input_id: :the_input_id,
          selected_date: '2023-08-04',
          hidden: false
        )
      )

      assert_selector('button#created_at_from_calendar--button_2023-08-04.text-white.font-semibold')
      assert_selector('time#created_at_from_calendar--time_2023-08-04.bg-gray-900')
    end
  end
end
