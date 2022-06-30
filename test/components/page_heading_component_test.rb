# frozen_string_literal: true

require 'test_helper'

class PageHeading::ComponentTest < ViewComponent::TestCase
  test 'renders title' do
    assert_equal(
      %(<h1 id="page_heading--title" class="text-xl font-semibold text-gray-900">My Title</h1>),
      render_inline(PageHeading::Component.new(title: 'My Title')).css('#page_heading--title').to_html
    )
  end

  test 'renders description' do
    assert_equal(
      %(<p id="page_heading--description" class="mt-2 text-sm text-gray-700">My Description</p>),
      render_inline(PageHeading::Component.new(title: 'My Title',
                                               description: 'My Description'
                                              )
                   ).css('#page_heading--description').to_html
    )
  end

  test 'renders actions' do
    assert_equal(
      %(<div id="page_heading--actions" class="mt-4 sm:mt-0 sm:ml-16 sm:flex-none" data-controller="resource">
      My Action
    </div>),
      render_inline(PageHeading::Component.new(title: 'My Title', description: 'My Description')) do |component|
        component.actions { 'My Action' }
      end.css('#page_heading--actions').to_html
    )
  end
end
