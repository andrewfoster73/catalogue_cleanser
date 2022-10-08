# frozen_string_literal: true

module ResourceForm
  class BaseComponent < ViewComponent::Base
    include IconsHelper

    # @return [String] the model attribute
    attr_reader :attribute
    # @return [String] the label for the field
    attr_reader :label
    # @return [ActiveRecord] the resource to retrieve the attribute from
    attr_reader :resource
    # @return [Hash] the additional configuration options for the field
    attr_reader :options

    # @param [String] attribute model attribute to either display or provide an input for
    # @param [String] label a label for the field, must have i18n already applied
    # @param [ActiveRecord] resource an instance of an ActiveRecord object to read data from
    # @param [Hash] options additional configuration options for the field
    # @option options [String] :help a message to place near the label to help the user understand the attribute
    # @option options [Boolean] :readonly is this attribute currently editable?
    # @option options [Boolean] :editable is this attribute ever editable?
    # @option options [Boolean] :required is this attribute required to have a value?
    # @option options [String] :invalid_message if this field is invalid what message to display
    # @option options [String] :url will convert display to be a link to another page
    def initialize(attribute:, label:, resource:, options: {})
      super
      @attribute = attribute
      @label = label
      @resource = resource
      @options = options.reverse_merge!(default_field_options)
    end

    private

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

    def url
      @options[:url]
    end

    def help
      @options[:help]
    end
  end
end
