# frozen_string_literal: true

class ItemSellPack < ApplicationRecord
  include Broadcast
  include Importable

  has_many :item_sell_pack_aliases, dependent: :destroy, strict_loading: true
  has_associated_audits

  audited

  scope :canonical, -> { where(canonical: true) }

  before_validation :clean, if: -> { data_source == 'manual' }

  validates :name, presence: true, uniqueness: true
  validates :canonical, inclusion: [true, false]

  def to_s
    name
  end

  protected

  def clean
    # Allowed characters are a-z and space
    assign_attributes(name: name&.downcase&.tr('^a-z ', ' ')&.squeeze(' ')&.strip)
  end
end
