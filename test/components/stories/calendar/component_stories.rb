# frozen_string_literal: true

module Calendar
  class ComponentStories < ApplicationStories
    story :basic do
      constructor(id: 'a_date', year: text('2022'), month: text('8'), input_id: 'an_input', hidden: false)
    end

    story :max_date do
      constructor(id: 'a_date', year: text('2022'), month: text('8'), input_id: 'an_input', max_date: text('2022-08-20'), hidden: false)
    end

    story :min_date do
      constructor(id: 'a_date', year: text('2022'), month: text('8'), input_id: 'an_input', min_date: text('2022-08-20'), hidden: false)
    end
  end
end
