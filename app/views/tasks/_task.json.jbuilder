# frozen_string_literal: true

json.extract!(task, :id, :type, :context_id, :context_type, :description, :before, :after, :status, :error,
              :requires_approval, :approved, :approved_at, :created_at, :updated_at
)
json.url(task_url(task, format: :json))
