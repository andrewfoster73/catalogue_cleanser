# frozen_string_literal: true

# DRY up controllers by extracting generic resource URL usage
module Urls
  extend ActiveSupport::Concern

  private

  def resource_url(resource)
    polymorphic_url(resource)
  end

  def collection_url
    polymorphic_url(resource_class)
  end
end
