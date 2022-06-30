# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  attr_accessor :form_authenticity_token

  def resource_name
    self.class.name.underscore
  end

  def resource_name_plural
    self.class.name.pluralize.underscore
  end
end
