# frozen_string_literal: true

class ItemPack < ApplicationRecord
  include Broadcast
  include Importable

  has_many :item_pack_aliases, dependent: :destroy, strict_loading: true
  has_associated_audits

  audited unless: :imported?

  before_validation :clean, unless: :imported?

  validates :name, presence: true, uniqueness: true

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
