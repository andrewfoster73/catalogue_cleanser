# frozen_string_literal: true

require 'application_system_test_case'

class NavigationTest < ApplicationSystemTestCase
  test 'expanding and closing the Item Setup menu' do
    visit products_url
    assert_no_selector(:css, '#item_setup--sub_navigation a')

    # Open the menu
    within('#side_bar--navigation') do
      click_on 'Item Setup'
    end
    assert_selector(:css, '#item_setup--sub_navigation a')

    # Close the menu
    within('#side_bar--navigation') do
      click_on 'Item Setup'
    end
    assert_no_selector(:css, '#item_setup--sub_navigation a')
  end

  test 'marking sub menu as active' do
    visit item_sell_packs_url
    assert_selector(:css, '#item_measures--navigation.text-gray-300')
    assert_selector(:css, '#item_sell_packs--navigation.bg-gray-900.text-white')
    assert_selector(:css, '#item_packs--navigation.text-gray-300')
    assert_selector(:css, '#brands--navigation.text-gray-300')
  end

  test 'marking sub menu as active when there are query parameters' do
    visit item_sell_packs_url(q: { name_cont: '' })
    assert_selector(:css, '#item_measures--navigation.text-gray-300')
    assert_selector(:css, '#item_sell_packs--navigation.bg-gray-900.text-white')
    assert_selector(:css, '#item_packs--navigation.text-gray-300')
    assert_selector(:css, '#brands--navigation.text-gray-300')
  end

  test 'following the Products navigation item' do
    visit brands_url
    within('#side_bar--navigation') do
      click_on 'Products'
    end
    assert_current_path('/products')
  end

  test 'following the Item Measures navigation item' do
    visit products_url
    within('#side_bar--navigation') do
      click_on 'Item Setup'
      click_on 'Item Measures'
    end
    assert_current_path('/item_measures')
  end

  test 'following the Item Packs navigation item' do
    visit products_url
    within('#side_bar--navigation') do
      click_on 'Item Setup'
      click_on 'Item Packs'
    end
    assert_current_path('/item_packs')
  end

  test 'following the Item Sell Packs navigation item' do
    visit products_url
    within('#side_bar--navigation') do
      click_on 'Item Setup'
      click_on 'Item Sell Packs'
    end
    assert_current_path('/item_sell_packs')
  end

  test 'following the Brands navigation item' do
    visit products_url
    within('#side_bar--navigation') do
      click_on 'Item Setup'
      click_on 'Brands'
    end
    assert_current_path('/brands')
  end
end
