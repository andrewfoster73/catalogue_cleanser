# frozen_string_literal: true

module ResourceForm
  class BaseComponent < ViewComponent::Base
    include IconsHelper

    attr_reader :attribute, :label, :resource, :options

    # options:
    # - help: String, A message to place near the label to help the user understand the attribute
    # - readonly: Boolean, is this attribute currently editable?
    # - editable: Boolean, is this attribute ever editable?
    # - required: Boolean, is this field required to have a value?
    # - invalid_message: String, if this field is invalid what message to display

    def initialize(attribute:, label:, resource:, options: {})
      super
      @attribute = attribute
      @label = label
      @resource = resource
      @options = options.reverse_merge!(default_field_options)
    end

    def default_field_options
      { help: nil, readonly: true, editable: true, required: false }
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

    def required?
      @options[:required]
    end

    def invalid_message
      @options[:invalid_message]
    end
  end
end
