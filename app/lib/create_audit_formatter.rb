# frozen_string_literal: true

# Formats a 'create' audit into a more human friendly message
class CreateAuditFormatter < BaseAuditFormatter
  # @param [Hash] changes the changes recorded by Audited against an auditable type
  # @return [String] a user friendly string describing the changes recorded by Audited
  def friendly(changes: {})
    I18n.t('audits.index.changes.create', model: type_class.model_name.human, attributes: record(resource: changes))
  end
end
