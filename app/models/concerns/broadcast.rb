# frozen_string_literal: true

module Broadcast
  extend ActiveSupport::Concern

  included do
    after_update_commit lambda {
      broadcast_replace_later_to(
        resource_name_plural,
        partial: "#{resource_name_plural}/row",
        locals: { resource: self },
        target: "turbo_stream_#{resource_name}_#{id}"
      )
    }, if: proc { |resource| resource.previous_changes.any? }
    after_update_commit lambda {
      broadcast_replace_later_to(
        resource_name,
        partial: "#{resource_name_plural}/resource",
        locals: { action: :show, resource: self, readonly: true, token: form_authenticity_token },
        target: "turbo_stream_show_#{resource_name}_#{id}"
      )
    }, if: proc { |resource| resource.previous_changes.any? }
    after_update_commit lambda {
      broadcast_replace_later_to(
        resource_name,
        partial: "#{resource_name_plural}/resource",
        locals: { action: :edit, resource: self, readonly: false, token: form_authenticity_token },
        target: "turbo_stream_edit_#{resource_name}_#{id}"
      )
    }, if: proc { |resource| resource.previous_changes.any? }
  end
end
