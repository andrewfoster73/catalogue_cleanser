# frozen_string_literal: true

module Tasks
  class StripWhitespace < Task
    def initialize(attributes = nil)
      super
      self.description = 'Removes any leading, trailing or extraneous whitespace from the attribute'
    end

    protected

    def execute
      Audited.audit_class.as_user("task-strip-whitespace-#{id}") do
        context.lock!.update_and_propagate(
          product_issue.test_attribute => product_issue.resolution_suggested_replacement
        )
        product_issue.fixed!
      end
    end
  end
end
