# frozen_string_literal: true

# Factory for building audit changes formatter based on the audit action
class AuditFormatterFactory
  class UnsupportedAuditActionError < StandardError; end
  class << self
    # @param [String] action the audit action that was recorded, must be one of the supported actions
    # @param [String] type the audit auditable_type that was recorded
    # @raise [UnsupportedAuditActionError] if the action provided is not one of 'destroy', 'create' or 'update'
    # @return [CreateAuditFormatter] if the action was 'create'
    # @return [UpdateAuditFormatter] if the action was 'update'
    # @return [DestroyAuditFormatter] if the action was 'destroy'
    # @example Where the audit record is in 'resource'
    #   AuditFormatterFactory.for(action: resource.action, type: resource.auditable_type)
    def for(action:, type:)
      case action
      when 'destroy'
        DestroyAuditFormatter.new(type: type)
      when 'create'
        CreateAuditFormatter.new(type: type)
      when 'update'
        UpdateAuditFormatter.new(type: type)
      else
        raise(UnsupportedAuditActionError, "Unsupported audit action: #{action}")
      end
    end
  end
end
