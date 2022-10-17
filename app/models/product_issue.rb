# frozen_string_literal: true

class ProductIssue < ApplicationRecord
  include Broadcast
  include NestedBroadcast

  belongs_to :product, inverse_of: :product_issues, optional: true
  belongs_to :product_translation, inverse_of: :product_issues, optional: true

  audited associated_with: :product

  scope :active_product_issues, lambda { |p, attr|
    where(product: p, test_attribute: attr).where.not(status: :fixed)
  }
  scope :active_translation_issues, lambda { |t, attr|
    where(product_translation: t, test_attribute: attr).where.not(status: :fixed)
  }
  scope :outstanding, -> { where.not(status: %i[fixed ignored]) }

  enum status: {
    pending: 'pending',
    confirmed: 'confirmed',
    ignored: 'ignored',
    fixed: 'fixed'
  }

  class << self
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

  def issue?
    self.class.issue?(product: product, product_translation: product_translation, attribute: test_attribute)
  end

  def parent
    product_translation || product
  end

  def fix!
    # build_resolution_task.call
    # self.status = 'fixed'
    raise(NotImplementedError)
  end

  def to_s
    "#{type.safe_constantize.model_name.human} - #{product_translation || product}"
  end

  private

  def automatic_confirmation?
    false
  end

  def build_resolution_task
    raise(NotImplementedError)
  end

  def nested_association_name
    # Need to use base class here because this table uses STI
    :product_issues
  end
end
