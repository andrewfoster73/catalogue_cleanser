# frozen_string_literal: true

class ItemSellPack < ApplicationRecord
  include Broadcast
  include Importable

  has_many :item_sell_pack_aliases, dependent: :destroy, strict_loading: true
  has_associated_audits

  audited unless: :imported?

  scope :canonical, -> { where(canonical: true) }

  before_validation :clean, unless: :imported?

  validates :name, presence: true, uniqueness: true
  validates :canonical, inclusion: [true, false]

  def self.ransackable_attributes(auth_object = nil)
    %w[canonical created_at data_source id item_sell_pack_aliases_count name updated_at]
  end

  def to_s
    name
  end

  protected

  def clean
    # Allowed characters are a-z and space
    assign_attributes(name: name&.downcase&.tr('^a-z ', ' ')&.squeeze(' ')&.strip)
  end
end
