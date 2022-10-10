# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Localisation

  add_flash_types :success, :information, :error, :warning

  unless Rails.env.production?
    around_action :n_plus_one_detection

    def n_plus_one_detection
      Prosopite.scan
      yield
    ensure
      Prosopite.finish
    end
  end

  protected

  def current_user
    nil
  end
end
