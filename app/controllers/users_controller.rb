# frozen_string_literal: true

class UsersController < ResourcesController
  private

  # Only allow a list of trusted parameters through.
  def permitted_params
    super | %i[locale country_alpha2]
  end
end
