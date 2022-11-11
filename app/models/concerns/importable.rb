# frozen_string_literal: true

# Any records that are imported should not be broadcast as it not necessary (this is done via the Initialise tasks).
# Only manually created records should be broadcast to other users.
module Importable
  extend ActiveSupport::Concern

  included do
    scope :imported, -> { where(data_source: :import) }
  end

  private

  def broadcast_creation?
    data_source != :import
  end

  def broadcast_update?
    data_source != :import
  end
end
