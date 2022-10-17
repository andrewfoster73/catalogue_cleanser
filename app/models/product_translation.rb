# frozen_string_literal: true

class ProductTranslation < ApplicationRecord
  include Broadcast
  include NestedBroadcast
  include IssueDiscovery

  belongs_to :product, inverse_of: :product_translations
  belongs_to :external_product_translation,
             class_name: 'External::ProductTranslation',
             inverse_of: :product_translation,
             optional: true
  has_many :product_issues, dependent: :destroy, strict_loading: true

  audited associated_with: :product

  class << self
    def supported_locales
      [
        { name: 'English', value: 'en' },
        { name: 'Thai', value: 'th' },
        { name: 'Chinese', value: 'zh' }
      ]
    end

    def supported_locales_alpha2s
      supported_locales.pluck(:value)
    end
  end

  def parent
    product
  end

  def to_s
    "#{item_description} (#{locale})"
  end

  private

  def issue_resources
    super.merge(product: product, product_translation: self)
  end
end
