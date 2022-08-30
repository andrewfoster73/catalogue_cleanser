# frozen_string_literal: true

class CommentsController < ResourcesController
  private

  # Only allow a list of trusted parameters through.
  def permitted_params
    super | %i[user_id message]
  end
end
