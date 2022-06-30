# frozen_string_literal: true

require 'test_helper'

class ResourceForm::ComponentTest < ViewComponent::TestCase
  def setup
    @resource = build(:item_sell_pack, id: 1, name: 'carton', canonical: true, created_at: Time.zone.now)
  end

  test 'rendering' do
    render_inline(
      ResourceForm::Component.new(
        action: :edit, title: 'The Resource', description: 'This is a resource', resource: @resource, token: 'token'
      )
    )

    assert_selector('form')
    assert_selector('#resource_form--title', text: 'The Resource')
    assert_selector('#resource_form--description', text: 'This is a resource')
    assert_selector('#authenticity_token', visible: false)
    assert_selector('#resource_form--method', visible: false)
  end

  test 'with fields' do
    render_inline(ResourceForm::Component.new(
      action: :edit, title: 'The Resource', description: 'This is a resource', resource: @resource, token: 'token'
    )
    ) do |component|
      component.with_field do |c|
        c.with_attribute_text(attribute: :name, label: 'Name', resource: @resource, options: { readonly: false })
      end

      component.with_field do |c|
        c.with_attribute_toggle(
          attribute: :canonical,
          label: 'Canonical',
          resource: @resource,
          options: {
            readonly: false,
            help: 'Name is acceptable to all users?'
          }
        )
      end

      component.with_field do |c|
        c.with_attribute_timestamp(attribute: :created_at, label: 'Created At', resource: @resource,
          options: { readonly: false }
        )
      end
    end

    assert_selector('#item_sell_pack_1_name--label', text: 'Name')
    assert_selector('input#item_sell_pack_1_name[value="carton"]')
    assert_selector('#item_sell_pack_1_canonical--label', text: 'Canonical')
    assert_selector('input#item_sell_pack_1_canonical[value="true"]', visible: false)
    assert_selector('#item_sell_pack_1_created_at--label', text: 'Created At')
    assert_selector('p#item_sell_pack_1_created_at')
  end
end
