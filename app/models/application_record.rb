# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

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
