# frozen_string_literal: true

module ResourceForm
  class BaseComponent < ViewComponent::Base
    include IconsHelper

    attr_reader :attribute, :label, :help, :resource, :readonly

    def initialize(attribute:, label:, resource:, help: nil, readonly: true)
      super
      @attribute = attribute
      @label = label
      @help = help
      @resource = resource
      @readonly = readonly
    end

    def field_id
      "#{resource.model_name.singular}_#{attribute}"
    end

    def field_name
      "#{resource.model_name.singular}[#{attribute}]"
    end
  end
end
