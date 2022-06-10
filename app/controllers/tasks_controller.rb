# frozen_string_literal: true

class TasksController < ResourcesController
  private

  # Only allow a list of trusted parameters through.
  def permitted_params
    %i[type context_id context_type description before after status error requires_approval approved approved_at]
  end
end
