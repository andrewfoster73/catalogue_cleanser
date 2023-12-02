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

  audited associated_with: :product, unless: :imported?

  before_validation :clean, unless: :imported?

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

    def ransackable_attributes(auth_object = nil)
      %w[brand created_at data_source external_product_translation_id id item_description item_measure item_pack_name item_sell_pack_name item_sell_quantity item_size locale product_id updated_at valid_locale valid_translations]
    end
  end

  # Use this when the product changes should possibly be propagated to the external product as well.
  # This will only occur if the attributes changed match those being mirrored from the external product.
  # @param [Hash] attributes the changed attributes to save
  # @return [Boolean] true if the update was successful, false otherwise
  def update_and_propagate(attributes)
    saved = update!(attributes)
    # TODO: Perform asynchronously
    if saved && Tasks::UpdateExternalProductTranslation.executable?(previous_changes)
      Tasks::UpdateExternalProductTranslation.create!(context: self).tap(&:call)
    end
    saved
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
