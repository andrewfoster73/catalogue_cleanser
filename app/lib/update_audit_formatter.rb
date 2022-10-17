# frozen_string_literal: true

# Formats a 'update' audit into a more human friendly message
class UpdateAuditFormatter < BaseAuditFormatter
  # @param [Hash] changes the changes recorded by Audited against an auditable type
  # @return [String] a user friendly string describing the changes recorded by Audited
  def friendly(changes: {})
    [
      I18n.t('audits.index.changes.resource', model: type_class.model_name.human),
      change_messages(changes: changes)
    ].join(' ')
  end

  private

  def change_messages(changes:)
    changes.to_a.map do |name, delta|
      I18n.t('audits.index.changes.update',
             attribute: human_attribute_name(name: name),
             from: from_value(delta: delta),
             to: to_value(delta: delta)
            )
    end.join(', ')
  end

  def human_attribute_name(name:)
    type_class.human_attribute_name(name)
  end

  def from_value(delta:)
    delta.first.presence || I18n.t('audits.index.empty')
  end

  def to_value(delta:)
    delta.second.presence || I18n.t('audits.index.empty')
  end
end
