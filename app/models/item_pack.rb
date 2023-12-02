# frozen_string_literal: true

class ItemPack < ApplicationRecord
  include Broadcast
  include Importable

  has_many :item_pack_aliases, dependent: :destroy, strict_loading: true
  has_associated_audits

  audited unless: :imported?

  before_validation :clean, unless: :imported?

  validates :name, presence: true, uniqueness: true

  def self.ransackable_attributes(auth_object = nil)
    %w[canonical created_at data_source id item_pack_aliases_count name updated_at]
  end

  # A string representation of the Item Pack that is used whenever an instance is converted to a string
  # @return [String] the name of the Item Pack
  def to_s
    name
  end

  protected

  def clean
    # Allowed characters are a-z and space
    assign_attributes(name: name&.downcase&.tr('^a-z ', ' ')&.squeeze(' ')&.strip)
  end
end
