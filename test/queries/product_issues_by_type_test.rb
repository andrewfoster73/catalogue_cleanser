# frozen_string_literal: true

require 'test_helper'

class ProductIssuesByTypeTest < ActiveSupport::TestCase
  setup do
    create(:product_issue, :pending, type: 'ProductIssues::MissingImage')
    create(:product_issue, :ignored, type: 'ProductIssues::AllUppercase')
    create(:product_issue, :confirmed, type: 'ProductIssues::MissingCompulsory')
    create(:product_issue, :fixed, type: 'ProductIssues::AdditionalWhitespace')
  end

  test 'returns count of completed tasks grouped by day' do
    results = Queries::ProductIssuesByType.to_h(scope: ProductIssue.outstanding)
    assert_includes(results.find { |r| r[:name] == 'pending' }[:data], ['Missing Image', 1])
    assert_includes(results.find { |r| r[:name] == 'confirmed' }[:data], ['Missing Compulsory Attribute', 2])
    assert_includes(results.find { |r| r[:name] == 'confirmed' }[:data], ['Invalid Locale', 1])
  end
end
