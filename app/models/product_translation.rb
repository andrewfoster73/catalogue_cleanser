# frozen_string_literal: true

class ProductTranslation < ApplicationRecord
  include Broadcast
  include NestedBroadcast
  include IssueDiscovery
  include Importable

  belongs_to :product, inverse_of: :product_translations, counter_cache: true
  belongs_to :external_product_translation,
             class_name: 'External::ProductTranslation',
             inverse_of: :product_translation,
             optional: true
  has_many :product_issues, dependent: :destroy, strict_loading: true

  audited associated_with: :product

  before_validation :clean, if: -> { data_source == 'manual' }

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

  # Use this when the product changes should possibly be propagated to the external product as well.
  # This will only occur if the attributes changed match those being mirrored from the external product.
  # @param [Hash] attributes the changed attributes to save
  # @return [Boolean] true if the update was successful, false otherwise
  def update_and_propagate(attributes)
    update!(attributes)
    # TODO: Perform asynchronously
    # TODO: Task for updating Translations
    # if saved && Tasks::UpdateExternalProduct.executable?(previous_changes)
    #   Tasks::UpdateExternalProduct.create!(context: self).tap(&:call)
    # end
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

  def clean
    assign_attributes(
      item_description: item_description&.squeeze(' ')&.strip.presence,
      brand: brand&.squeeze(' ')&.strip.presence
    )
  end
end
