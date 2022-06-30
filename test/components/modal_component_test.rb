# frozen_string_literal: true

require 'test_helper'

class Modal::ComponentTest < ViewComponent::TestCase
  test 'with a confirmation message' do
    render_inline(Modal::Component.new(name: :the_modal, hidden: false)) do |component|
      component.with_confirmation(
        title: 'Delete',
        icon_options: { name: :exclamation, colour: :red, options: { classes: '' } },
        message: 'Are you sure you want to delete this? This action cannot be undone.'
      )
    end

    assert_selector('#the_modal--icon', text: '')
    assert_selector('#the_modal--title', text: 'Delete')
    assert_selector('#the_modal--message', text: 'Are you sure you want to delete this? This action cannot be undone.')
  end

  test 'without a confirmation message' do
    render_inline(Modal::Component.new(name: :the_modal, hidden: false))

    assert_selector('#the_modal--close')
    assert_selector('button[data-action="click->modal--component#close"]')
    assert_selector('button[data-modal--component-name-param="the_modal"]')
    assert_selector('#the_modal--content', text: '')
  end

  test 'with a button' do
    render_inline(Modal::Component.new(name: :the_modal, hidden: false)) do |component|
      component.with_button(
        id: :confirm_delete,
        label: 'Delete',
        options: {
          icon: { name: :trash, colour: :white },
          colour_classes: 'text-white bg-rose-500 hover:bg-rose-600 focus:ring-rose-200',
          data: {
            params: [
              { name: 'resource-id', value: '' },
              { name: 'resource-url', value: 'the.url' },
              { name: 'resource-modal-name', value: :delete_confirmation }
            ],
            action: 'click->resource#inlineDelete'
          }
        }
      )
    end

    assert_selector('#the_modal--buttons button#confirm_delete', text: 'Delete')
  end
end
