# frozen_string_literal: true

class ItemSellPackAlias < ApplicationRecord
  include Broadcast
  include NestedBroadcast
  include Importable

  belongs_to :item_sell_pack, inverse_of: :item_sell_pack_aliases, counter_cache: true

  audited associated_with: :item_sell_pack

  before_validation :clean, unless: :imported?

  validates :alias, presence: true, uniqueness: true

  def self.ransackable_attributes(auth_object = nil)
    %w[alias confirmed created_at data_source id item_sell_pack_id updated_at]
  end

  def parent
    item_sell_pack
  end

  def to_s
    "#{self.alias} (#{item_sell_pack})"
  end

  protected

  def clean
    # Allowed characters are a-z and space
    assign_attributes(alias: self.alias&.downcase&.tr('^a-z ', ' ')&.squeeze(' ')&.strip)
  end
end
