# frozen_string_literal: true

module Broadcast
  extend ActiveSupport::Concern

  # rubocop:disable Metrics/BlockLength
  included do
    after_create_commit lambda {
      broadcast_prepend_later_to(
        resource_name_plural,
        partial: "#{resource_name_plural}/row",
        locals: { resource: self },
        target: 'collection_rows'
      )
    }
    after_destroy_commit lambda {
      broadcast_remove_to(
        resource_name_plural,
        target: "turbo_stream_#{resource_name}_#{id}"
      )
      # TODO: Do not broadcast to user performing deletion
      broadcast_append_to(
        resource_name_plural,
        partial: 'notification',
        locals: {
          name: "notification_#{resource_name}_#{id}",
          type: 'information',
          message: "A user deleted '#{self}'."
        },
        target: 'notifications'
      )
      broadcast_append_to(
        "notification_#{resource_name}_#{id}",
        partial: 'notification',
        locals: {
          name: "notification_#{resource_name}_#{id}",
          type: 'warning',
          message: 'Another user deleted this record!'
        },
        target: 'notifications'
      )
    }
    after_update_commit lambda {
      broadcast_replace_later_to(
        resource_name_plural,
        partial: "#{resource_name_plural}/row",
        locals: { resource: self },
        target: "turbo_stream_#{resource_name}_#{id}"
      )
      broadcast_replace_later_to(
        resource_name,
        partial: "#{resource_name_plural}/resource",
        locals: { action: :show, resource: self, readonly: true, token: form_authenticity_token },
        target: "turbo_stream_show_#{resource_name}_#{id}"
      )
      broadcast_replace_later_to(
        resource_name,
        partial: "#{resource_name_plural}/resource",
        locals: { action: :edit, resource: self, readonly: false, token: form_authenticity_token },
        target: "turbo_stream_edit_#{resource_name}_#{id}"
      )
      broadcast_append_to(
        "notification_#{resource_name}_#{id}",
        partial: 'notification',
        locals: {
          name: "notification_#{resource_name}_#{id}",
          type: 'warning',
          message: 'Another user has updated this record.'
        },
        target: 'notifications'
      )
    }
  end
  # rubocop:enable Metrics/BlockLength
end
