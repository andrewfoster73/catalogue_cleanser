# frozen_string_literal: true

require 'test_helper'

class CollectionFilter::DateRangeComponentTest < ViewComponent::TestCase
  test 'rendering' do
    render_inline(CollectionFilter::DateRangeComponent.new(attribute: :created_at))

    assert_selector('label[for="q_created_at_gteq"]', text: 'Created at is on or after')
    assert_selector('input#q_created_at_gteq[name="q[created_at_gteq]"]')
    assert_selector('label[for="q_created_at_lteq"]', text: 'Created at is on or before')
    assert_selector('input#q_created_at_lteq[name="q[created_at_lteq]"]')
  end

  test 'when there is a to date set' do
    travel_to(Time.zone.local(2022, 8, 5)) do
      render_inline(CollectionFilter::DateRangeComponent.new(attribute: :created_at, to_date: '2022-08-10'))

      assert_selector('#q_created_at_gteq[max="2022-08-10"]')
      assert_selector(
        'button#created_at_from_calendar--button_2022-08-10[data-action="click->calendar--component#selectDate"]',
        visible: false
      )
      assert_no_selector(
        'button#created_at_from_calendar--button_2022-08-11[data-action="click->calendar--component#selectDate"]',
        visible: false
      )
    end
  end

  test 'when there is a from date set' do
    travel_to(Time.zone.local(2022, 8, 5)) do
      render_inline(CollectionFilter::DateRangeComponent.new(attribute: :created_at, from_date: '2022-08-11'))

      assert_selector('#q_created_at_lteq[min="2022-08-11"]')
      assert_no_selector(
        'button#created_at_to_calendar--button_2022-08-10[data-action="click->calendar--component#selectDate"]',
        visible: false
      )
      assert_selector(
        'button#created_at_to_calendar--button_2022-08-11[data-action="click->calendar--component#selectDate"]',
        visible: false
      )
    end
  end
end
