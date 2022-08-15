# frozen_string_literal: true

module NestedBroadcast
  extend ActiveSupport::Concern

  included do
    after_create_commit lambda {
      broadcast_nested_resource_creation
      broadcast_nested_resource_count
    }

    after_destroy_commit lambda {
      broadcast_nested_resource_deletion
      broadcast_nested_resource_count
    }

    after_update_commit lambda {
      broadcast_nested_resource_update
    }
  end

  private

  def broadcast_nested_resource_creation
    broadcast_prepend_later_to(
      broadcast_nested_collection_channel,
      partial: "#{resource_name_plural}/row",
      locals: { resource: self },
      target: 'collection_rows'
    )
  end

  def broadcast_nested_resource_deletion
    broadcast_remove_to(
      broadcast_nested_collection_channel,
      target: "turbo_stream_#{resource_name}_#{id}"
    )
  end

  def broadcast_nested_resource_update
    broadcast_replace_later_to(
      broadcast_nested_collection_channel,
      partial: "#{resource_name_plural}/row",
      locals: { resource: self },
      target: "turbo_stream_#{resource_name}_#{id}"
    )
  end

  def broadcast_nested_resource_count
    # Not using _later_ here to avoid an ActiveJob::DeserializationError when records are deleted
    broadcast_replace_to(
      "#{nested_resource_collection_id}_count",
      partial: 'badge_count',
      locals: {
        tab_id: nested_resource_collection_id,
        badge_count: parent.public_send(parent.klass_association_name(klass: self.class)).size
      },
      target: "tab_#{nested_resource_collection_id}--badge_count__integer"
    )
  end

  def broadcast_nested_collection_channel
    "#{parent.resource_name}_#{parent.id}_#{resource_name_plural}"
  end

  def nested_resource_collection_id
    "#{parent.resource_name}_#{parent.id}_#{parent.klass_association_name(klass: self.class)}"
  end
end