# frozen_string_literal: true

# Base class for all persisted models
# @abstract
class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  include Parent

  attr_accessor :form_authenticity_token

  class << self
    def resource_name
      name.underscore
    end

    def resource_name_plural
      name.pluralize.underscore
    end
  end

  def resource_name
    self.class.resource_name
  end

  def resource_name_plural
    self.class.resource_name_plural
  end
end
