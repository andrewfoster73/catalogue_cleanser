# frozen_string_literal: true

# Formats a 'destroy' audit into a more human friendly message
class DestroyAuditFormatter < BaseAuditFormatter
  # @param [Hash] changes the changes recorded by Audited against an auditable type
  # @return [String] a user friendly string describing the changes recorded by Audited
  def friendly(changes: {})
    I18n.t('audits.index.changes.destroy', model: type_class.model_name.human, attributes: record(resource: changes))
    "#{type_class.model_name.human} with attributes: [#{record(resource: changes)}] was deleted."
  end
end
