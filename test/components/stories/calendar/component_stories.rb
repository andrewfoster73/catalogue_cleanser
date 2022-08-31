# frozen_string_literal: true

module Calendar
  class ComponentStories < ApplicationStories
    story :basic do
      constructor(id: 'a_date', year: text('2022'), month: text('8'), input_id: 'an_input', hidden: false)
    end
  end
end
