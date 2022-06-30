# frozen_string_literal: true

require 'test_helper'

class EditableCell::ComponentTest < ViewComponent::TestCase
  def setup
    @resource = build(:item_sell_pack, name: 'carton', canonical: true, created_at: Time.zone.now)
  end

  test 'renders' do
    render_inline(EditableCell::Component.new(url: '/item_sell_packs/1/edit', resource: @resource, attribute: :name))

    assert_selector('div#name_turbo_stream_item_sell_pack')
    assert_selector('#name_turbo_frame_item_sell_pack')
    assert_selector('a[href="/item_sell_packs/1/edit"]', text: 'carton')
    assert_selector('a.editable-element')
  end
end
