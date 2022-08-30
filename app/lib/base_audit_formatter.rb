# frozen_string_literal: true

# @abstract Subclass and override {#friendly} to implement a formatter for a specific Audit action
class BaseAuditFormatter
  attr_accessor :type

  # @param [String] type the auditable_type of the audit record, this will be a class name
  def initialize(type:)
    @type = type
  end

  # @param [Hash] changes the changes recorded by Audited against an auditable type
  # @return [String] a user friendly string describing the changes recorded by Audited
  # @example Using the factory and passing in the changes
  #   AuditFormatterFactory
  #     .for(action: resource.action, type: resource.auditable_type)
  #     .friendly(changes: resource.audited_changes)
  def friendly(changes: {})
    raise(NotImplementedError)
  end

  private

  def type_class
    type.safe_constantize
  end

  def record(resource: audited_changes)
    return if resource.nil?

    resource.map do |k, v|
      "#{type_class.human_attribute_name(k)} - #{v}"
    end.join(', ')
  end
end
