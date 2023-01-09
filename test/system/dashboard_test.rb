# frozen_string_literal: true

require 'application_system_test_case'

class DashboardTest < ApplicationSystemTestCase
  test 'redirects if not logged in' do
    visit dashboard_url
    assert_current_path(root_url)
  end

  test 'displays all dashboard widgets' do
    login
    visit dashboard_url

    save_html

    assert_selector('#dashboard_central_products--label', text: 'Central Catalogue Products')
    assert_selector('#dashboard_central_products--count', text: '0')
    assert_selector('#dashboard_likely_duplicates--label', text: 'Likely Duplicates')
    assert_selector('#dashboard_likely_duplicates--count', text: 'TBC')
    assert_selector('#dashboard_tasks_awaiting_approval--label', text: 'Tasks Awaiting Approval')
    assert_selector('#dashboard_tasks_awaiting_approval--count', text: '0')
    assert_selector('#dashboard_issues_awaiting_confirmation--label', text: 'Product Issues Awaiting Confirmation')
    assert_selector('#dashboard_issues_awaiting_confirmation--count', text: '0')
    assert_selector('#dashboard_products_on_buy_lists--label', text: 'Products on Buy Lists')
    assert_selector('#dashboard_products_on_buy_lists--count_number', text: '3')
    assert_selector('#dashboard_products_on_buy_lists--count_percentage', text: '100.00%')
    assert_selector('#dashboard_products_on_priced_catalogues--label', text: 'Products on Priced Catalogues')
    assert_selector('#dashboard_products_on_priced_catalogues--count_number', text: '3')
    assert_selector('#dashboard_products_on_priced_catalogues--count_percentage', text: '100.00%')
    assert_selector('#dashboard_products_on_transactions--label', text: 'Products on Transactions')
    assert_selector('#dashboard_products_on_transactions--count_number', text: '3')
    assert_selector('#dashboard_products_on_transactions--count_percentage', text: '100.00%')
    assert_selector('#dashboard_products_in_settings--label', text: 'Products in Settings')
    assert_selector('#dashboard_products_in_settings--count_number', text: '3')
    assert_selector('#dashboard_products_in_settings--count_percentage', text: '100.00%')
    assert_selector(
      '#dashboard_products_used_vs_not_used--label',
      text: 'The percentage of products that are being used anywhere (catalogues, transactions, settings) versus those that are entirely unused.'
    )
    assert_selector('#dashboard_products_used_vs_not_used--chart > canvas')
    assert_selector(
      '#dashboard_products_with_issues_vs_none--label',
      text: 'The percentage of products that have one or more unresolved issues versus those that have none.'
    )
    assert_selector('#dashboard_products_with_issues_vs_none--chart > canvas')
    assert_selector(
      '#dashboard_products_issues_by_type--label',
      text: 'The types of issues present and their counts.'
    )
    assert_selector('#dashboard_products_issues_by_type--chart > canvas')
    assert_selector(
      '#dashboard_tasks_completed_by_day--label',
      text: 'The number of completed tasks executed each day.'
    )
    assert_selector('#dashboard_tasks_completed_by_day--chart')
    assert_selector(
      '#dashboard_products_created_by_month--label',
      text: 'The number of products added to the central catalogue each month.'
    )
    assert_selector('#dashboard_products_created_by_month--chart')
  end
end
