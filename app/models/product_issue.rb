# frozen_string_literal: true

class ProductIssue < ApplicationRecord
  include Broadcast
  include NestedBroadcast
  include Importable

  belongs_to :product, inverse_of: :product_issues, optional: true
  belongs_to :product_translation, inverse_of: :product_issues, optional: true
  counter_culture :product,
                  execute_after_commit: true,
                  column_name: proc { |model| model.outstanding? ? :product_issues_outstanding_count : nil }

  audited associated_with: :product

  scope :active_product_issues, lambda { |p, attr|
    where(product: p, test_attribute: attr).where.not(status: :fixed)
  }
  scope :active_translation_issues, lambda { |t, attr|
    where(product_translation: t, test_attribute: attr).where.not(status: :fixed)
  }
  scope :outstanding, -> { where.not(status: %i[fixed ignored]) }
  scope :requiring_confirmation, -> { where(status: 'pending') }
  scope :kept, -> { joins(:product).where(products: { discarded_at: nil }) }

  # Pending - identified but may need manual confirmation of validity
  # Confirmed - issue is deemed valid but not resolved
  # Ignored - manually marked as not an issue
  # Fixed - fix has been applied either manually or by automated task
  enum status: {
    pending: 'pending',
    confirmed: 'confirmed',
    ignored: 'ignored',
    fixed: 'fixed'
  }

  class << self
    def products_with_issues_count
      outstanding.distinct.pluck(:product_id).size
    end

    # Builds a new Product Issue for the given product and/or translation with an optional attribute that is problematic
    #
    # @param [ActiveRecord] product the product that has an issue
    # @param [ActiveRecord] product_translation the translation that has an issue
    # @param [Symbol] attribute the attribute that has an issue
    # @example Issue for item_description on Product
    #   build(product: product, attribute: :item_description)
    # @example Issue for locale on Product Translation
    #   build(product: product, product_translation: translation, attribute: :locale)
    # @return new ProductIssue
    def build(product:, product_translation: nil, attribute: nil)
      return nil unless issue?(product: product, product_translation: product_translation, attribute: attribute)

      new(product: product, product_translation: product_translation, test_attribute: attribute)
    end

    # Checks if there is any issues for the given product and/or translation with an optional attribute. The type
    # of ProductIssue will be looking for different types of problems
    #
    # @param [ActiveRecord] product the product to check
    # @param [ActiveRecord] product_translation the translation to check
    # @param [Symbol] attribute the attribute to check
    # @example Is there an issue for item_description on the product?
    #   issue?(product: product, attribute: :item_description)
    # @example Is there an issue for locale on the product translation?
    #   issue?(product: product, product_translation: translation, attribute: :locale)
    # @return true if the product or translation has an issue that needs to be resolved, false otherwise
    def issue?(product:, product_translation: nil, attribute: nil)
      raise(NotImplementedError)
    end

    def resource_name
      :product_issue
    end

    def resource_name_plural
      :product_issues
    end
  end

  def initialize(attributes = nil)
    super
    self.status = 'pending'
    self.status = 'confirmed' if automatic_confirmation?
  end

  def already_identified?
    return self.class.active_product_issues(product, test_attribute).any? if product && !product_translation
    return self.class.active_translation_issues(product_translation, test_attribute).any? if product_translation

    false
  end

  # @return [Boolean] true if there is an issue of the current type for the product or translation, false otherwise
  def issue?
    self.class.issue?(product: product, product_translation: product_translation, attribute: test_attribute)
  end

  # Is resolution of this issue still outstanding?
  # @return [Boolean] true if the issue still needs to be resolved, false otherwise
  def outstanding?
    %w[fixed ignored].exclude?(status)
  end

  def parent
    product_translation || product
  end

  def imported?
    parent.data_source == 'import'
  end

  # If an automatic resolution task is available then call it
  # Otherwise the user will have to manually edit the product and/or translation in order to resolve any issues
  def fix!
    create_resolution_task.call if resolution_task_type
  end

  # A string representation of the ProductIssue that is used whenever an instance is converted to a string
  # @return [String] the humanised name of the Issue type and the string representation of it's translation or product
  def to_s
    "#{type.safe_constantize.model_name.human} - #{product_translation || product}"
  end

  private

  def automatic_confirmation?
    false
  end

  def create_resolution_task
    raise(NotImplementedError)
  end

  def nested_association_name
    # Need to use base class here because this table uses STI
    :product_issues
  end

  def broadcast_nested_collection_channels
    # Need to broadcast to both parents (if applicable)
    [
      ("#{product_translation.resource_name}_#{product_translation.id}_#{resource_name_plural}" if product_translation),
      "#{product.resource_name}_#{product.id}_#{resource_name_plural}"
    ].compact
  end
end
