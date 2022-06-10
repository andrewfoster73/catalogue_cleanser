# frozen_string_literal: true

# DRY up controllers by extracting generic parameter processing
module Parameters
  extend ActiveSupport::Concern

  private

  def resource_params
    params.require(resource_name).permit(permitted_params)
  end

  def permitted_params
    []
  end
end
