# frozen_string_literal: true

require 'test_helper'

# rubocop:disable Layout/LineLength
class Button::ComponentTest < ViewComponent::TestCase
  test 'with no options' do
    assert_equal(
      %(<button id="delete" type="button" title="" class=" inline-flex items-center px-3 py-2 border border-transparent shadow-sm text-sm leading-4 font-medium rounded-full focus:outline-none focus:ring-2 focus:ring-offset-2" data-action="">
  Delete
</button>),
      render_inline(Button::Component.new(id: :delete, label: 'Delete')).css('button').to_html
    )
  end

  test 'with options' do
    assert_equal(
      %(<button id="view" type="button" title="path" class="text-white bg-indigo-600 hover:bg-indigo-700 focus:ring-indigo-200 inline-flex items-center px-3 py-2 border border-transparent shadow-sm text-sm leading-4 font-medium rounded-full focus:outline-none focus:ring-2 focus:ring-offset-2" data-action="click-&gt;resource#navigate" data-resource-url-param="path">
    <svg class="text-white group-hover:text-white mr-3 flex-shrink-0 h-6 w-6" xmlns="http://www.w3.org/2000/svg" fill="none" viewbox="0 0 24 24" stroke="currentColor" aria-hidden="true"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"></path><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"></path></svg>
  View
</button>),
      render_inline(Button::Component.new(
                      id: :view,
                      label: 'View',
                      options: {
                        title: 'path',
                        icon: { name: :eye, colour: :white },
                        colour_classes: 'text-white bg-indigo-600 hover:bg-indigo-700 focus:ring-indigo-200',
                        data: {
                          params: [{ name: 'resource-url', value: 'path' }],
                          action: 'click->resource#navigate'
                        }
                      }
                    )
                   ).css('button').to_html
    )
  end
end
# rubocop:enable Layout/LineLength
