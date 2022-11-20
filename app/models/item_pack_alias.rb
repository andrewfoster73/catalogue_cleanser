# frozen_string_literal: true

class ItemPackAlias < ApplicationRecord
  include Broadcast
  include NestedBroadcast
  include Importable

  belongs_to :item_pack, counter_cache: true

  audited associated_with: :item_pack

  before_validation :clean, if: -> { data_source == 'manual' }

  validates :alias, presence: true, uniqueness: true

  # The parent object to use whenever the ItemPackAlias appears nested
  # @return [ItemPack] the item pack this alias belongs to
  def parent
    item_pack
  end

  # A string representation of the ItemPackAlias that is used whenever an instance is converted to a string
  # @return [String] the alias concatenated with the string description of the item pack it belongs to
  def to_s
    "#{self.alias} (#{item_pack})"
  end

  protected

  def clean
    # Allowed characters are a-z and space
    assign_attributes(alias: self.alias&.downcase&.tr('^a-z ', ' ')&.squeeze(' ')&.strip)
  end
end
