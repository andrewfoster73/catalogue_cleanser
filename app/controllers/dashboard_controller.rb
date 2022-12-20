# frozen_string_literal: true

class DashboardController < ApplicationController
  include Authenticated

  helper_method :navigation_path, :dashboard

  def percentage_products_with_issues_vs_none
    render(json:
      {
        t('.labels.no_issues') => dashboard.percentage_products_no_issues,
        t('.labels.issues') => dashboard.percentage_products_with_issues
      }
          )
  end

  def percentage_products_used_vs_not_used
    render(json:
      {
        t('.labels.used') => dashboard.percentage_products_used,
        t('.labels.not_used') => dashboard.percentage_products_not_used
      }
          )
  end

  def products_created_by_month
    render(json: Queries::ProductsCreatedByMonth.to_h)
  end

  def product_issues_by_type
    render(json: Queries::ProductIssuesByType.to_h(scope: ProductIssue.outstanding))
  end

  def tasks_completed_by_day
    render(json: Queries::TasksCompletedByDay.to_h)
  end

  private

  def navigation_path
    dashboard_url
  end

  def dashboard
    @dashboard ||= Dashboard.new
  end
end
