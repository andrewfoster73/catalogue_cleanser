# frozen_string_literal: true

class CommentsController < ResourcesController
  private

  # Only allow a list of trusted parameters through.
  def permitted_params
    %i[user_id message]
  end
end
