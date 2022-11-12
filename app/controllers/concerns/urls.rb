# frozen_string_literal: true

# DRY up controllers by extracting generic resource URL usage
module Urls
  extend ActiveSupport::Concern

  included do
    helper_method :navigation_path
  end

  private

  def resource_url(resource, options = {})
    polymorphic_url(resource, options)
  end

  def collection_url(options = {})
    polymorphic_url(resource_class, options)
  end

  def navigation_path
    collection_url
  end
end
