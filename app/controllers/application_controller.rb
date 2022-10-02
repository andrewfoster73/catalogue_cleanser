# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Localisation

  add_flash_types :success, :information, :error, :warning

  protected

  def current_user
    nil
  end
end
