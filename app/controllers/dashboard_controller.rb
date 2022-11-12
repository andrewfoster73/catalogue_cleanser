# frozen_string_literal: true

class DashboardController < ApplicationController
  include Authenticated

  helper_method :navigation_path

  private

  def navigation_path
    dashboard_url
  end
end
