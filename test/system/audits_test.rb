# frozen_string_literal: true

require 'application_system_test_case'

class AuditsTest < ApplicationSystemTestCase
  setup do
    @item_sell_pack = item_sell_packs(:carton)
  end

  test 'redirects if not logged in' do
    visit item_sell_pack_audits_url(item_sell_pack_id: @item_sell_pack)
    assert_current_path(root_url)
  end

  test 'visiting the index' do
    login
    visit item_sell_pack_audits_url(item_sell_pack_id: @item_sell_pack)
    assert_selector 'h1', text: 'Audits'
    assert_selector('#action_list--label', text: 'Actions')
    assert_selector('#action_list--count', text: '0')
    assert_selector('label[for="q_created_at_gteq"]', text: 'Created at is on or after')
    assert_selector('input#q_created_at_gteq[name="q[created_at_gteq]"]')
    assert_selector('label[for="q_created_at_lteq"]', text: 'Created at is on or before')
    assert_selector('input#q_created_at_lteq[name="q[created_at_lteq]"]')

    find('#action_list--label').click
    assert_selector('input#action_list--option_0[name="q[action_in][]"][value="create"]', visible: true)
    assert_selector('label[for="action_list--option_0"]', text: 'Create', visible: true)
    assert_selector('input#action_list--option_1[name="q[action_in][]"][value="update"]', visible: true)
    assert_selector('label[for="action_list--option_1"]', text: 'Update', visible: true)
    assert_selector('input#action_list--option_2[name="q[action_in][]"][value="destroy"]', visible: true)
    assert_selector('label[for="action_list--option_2"]', text: 'Destroy', visible: true)
  end

  test 'index page tabs' do
    login
    visit item_sell_pack_audits_url(item_sell_pack_id: @item_sell_pack)
    assert_selector("a#tab_item_sell_pack_#{item_sell_packs(:carton).id}_details", text: 'Details')
    assert_selector("a#tab_item_sell_pack_#{item_sell_packs(:carton).id}_item_sell_pack_aliases", text: 'Aliases')
    assert_selector("a#tab_item_sell_pack_#{item_sell_packs(:carton).id}_audit", text: 'Audit')

    click_on 'Details'
    assert_current_path(item_sell_pack_url(item_sell_packs(:carton).id))
    visit item_sell_pack_item_sell_pack_aliases_url(item_sell_pack_id: item_sell_packs(:carton))
    click_on 'Aliases'
    assert_current_path(item_sell_pack_item_sell_pack_aliases_url(item_sell_pack_id: item_sell_packs(:carton)))
  end
end
