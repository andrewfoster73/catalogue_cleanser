# frozen_string_literal: true

require 'test_helper'

class ResourceForm::TimestampComponentTest < ViewComponent::TestCase
  include ActionView::Helpers::DateHelper

  def setup
    freeze_time
    @resource = build(:item_sell_pack, id: 1, name: 'carton', canonical: true, created_at: Time.zone.now)
  end

  test 'editable mode' do
    render_inline(ResourceForm::FieldComponent.new) do |component|
      component.with_attribute_timestamp(
        attribute: :created_at,
        label: 'Created At',
        resource: @resource,
        options: { readonly: false }
      )
    end

    assert_selector('#item_sell_pack_1_created_at--label')
    assert_selector('label[for="item_sell_pack_1_created_at"]', text: 'Created At')
    assert_selector(
      'p#item_sell_pack_1_created_at',
      text: "#{time_ago_in_words(Time.zone.now, include_seconds: true)} ago"
    )
  end

  test 'readonly mode' do
    render_inline(ResourceForm::FieldComponent.new) do |component|
      component.with_attribute_timestamp(
        attribute: :created_at,
        label: 'Created At',
        resource: @resource,
        options: { readonly: true }
      )
    end

    assert_selector('#item_sell_pack_1_created_at--label')
    assert_selector('label[for="item_sell_pack_1_created_at"]', text: 'Created At')
    assert_selector(
      'p#item_sell_pack_1_created_at',
      text: "#{time_ago_in_words(Time.zone.now, include_seconds: true)} ago"
    )
  end

  test 'with help text' do
    render_inline(ResourceForm::FieldComponent.new) do |component|
      component.with_attribute_timestamp(
        attribute: :created_at,
        label: 'Created At',
        resource: @resource,
        options: {
          readonly: false,
          help: 'This is a help message'
        }
      )
    end

    assert_selector('#item_sell_pack_1_created_at--help', text: 'This is a help message')
  end
end
