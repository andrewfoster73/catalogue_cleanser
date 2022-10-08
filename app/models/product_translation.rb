# frozen_string_literal: true

class ProductTranslation < ApplicationRecord
  include Broadcast
  include NestedBroadcast

  belongs_to :product

  audited associated_with: :product

  delegate :to_s, to: :product_id

  class << self
    def supported_locales
      [
        { name: 'English', value: 'en' },
        { name: 'Thai', value: 'th' },
        { name: 'Chinese', value: 'zh' }
      ]
    end
  end

  def parent
    product
  end

  def to_s
    "#{item_description} (#{locale})"
  end
end
