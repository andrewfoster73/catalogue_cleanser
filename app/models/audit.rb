# frozen_string_literal: true

class Audit < Audited::Audit
  def self.ransackable_attributes(auth_object = nil)
    %w[action associated_id associated_type auditable_id auditable_type audited_changes comment created_at id remote_address request_uuid user_id user_type username version]
  end
end