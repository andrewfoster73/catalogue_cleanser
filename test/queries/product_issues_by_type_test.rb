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
    assert_includes(results.to_a, ['Missing Image', 1])
    # Second one comes from the fixtures
    assert_includes(results.to_a, ['Missing Compulsory Attribute', 2])
    # Comes from the fixtures
    assert_includes(results.to_a, ['Invalid Locale', 1])
    assert_not_includes(results.to_a, ['All Uppercase', 1])
    assert_not_includes(results.to_a, ['Extraneous Whitespace', 1])
  end
end
