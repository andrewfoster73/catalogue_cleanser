# frozen_string_literal: true

module ResourceForm
  class BaseComponent < ViewComponent::Base
    include IconsHelper

    attr_reader :attribute, :label, :resource, :options

    # options:
    # - help: A message to place near the label to help the user understand the attribute
    # - readonly: Is this attribute currently editable?
    # - editable: Is this attribute ever editable?

    def initialize(attribute:, label:, resource:, options: {})
      super
      @attribute = attribute
      @label = label
      @resource = resource
      @options = options.reverse_merge!(default_field_options)
    end

    def default_field_options
      { help: nil, readonly: true, editable: true }
    end

    def field_id
      "#{resource.model_name.singular}_#{resource.id || 'new'}_#{attribute}"
    end

    def field_name
      "#{resource.model_name.singular}[#{attribute}]"
    end

    def display_only?
      @options[:readonly] || !@options[:editable]
    end
  end
end
