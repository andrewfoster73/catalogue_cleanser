# frozen_string_literal: true

# Apply different rules for when the resource is nested under another
module Nested
  extend ActiveSupport::Concern

  included do
    helper_method :nested?, :filter_url
  end

  private

  def build_resource
    super.tap do |r|
      r.send("#{parent_association_name}=", parent)
    end
  end

  def filter_url
    nil
  end

  def default_filters
    return {} unless nested?

    { "#{parent_foreign_key}_eq": parent.id }
  end

  def nested?
    parent.present?
  end

  def parent_class
    raise(NotImplementedError)
  end

  def parent
    raise(NotImplementedError)
  end

  def parent_association
    resource_class
      .reflect_on_all_associations(:belongs_to)
      .find { |a| a.name == parent_class.resource_name.to_sym }
  end

  def parent_foreign_key
    parent_association.foreign_key
  end

  def parent_association_name
    parent_association.name
  end
end
