# frozen_string_literal: true

# Formats a 'update' audit into a more human friendly message
class UpdateAuditFormatter < BaseAuditFormatter
  # @param [Hash] changes the changes recorded by Audited against an auditable type
  # @return [String] a user friendly string describing the changes recorded by Audited
  def friendly(changes: {})
    [
      human_attribute_name(changes: changes),
      'was changed from',
      from_value(changes: changes),
      'to',
      to_value(changes: changes)
    ].join(' ')
  end

  private

  def human_attribute_name(changes:)
    type_class.human_attribute_name(changes.keys.first)
  end

  def from_value(changes:)
    changes.values.first.first
  end

  def to_value(changes:)
    changes.values.first.second
  end
end
