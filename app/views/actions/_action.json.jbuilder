# frozen_string_literal: true

json.extract!(action, :id, :type, :context_id, :context_type, :description, :before, :after, :status, :error,
              :requires_approval, :approved, :approved_by_id, :approved_at, :created_at, :updated_at
)
json.url(action_url(action, format: :json))
