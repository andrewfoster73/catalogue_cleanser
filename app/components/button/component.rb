# frozen_string_literal: true

module Button
  class Component < ViewComponent::Base
    include IconsHelper

    # @return [String] the identifier added to the HTML button tag
    attr_reader :id
    # @return [String] the label that appears on the button
    attr_reader :label
    # @return [Hash] the additional configuration options for the button
    attr_reader :options

    # @param [String] id the identifier to add to the HTML button tag
    # @param [String] label the text to use as a label, must have i18n already applied
    # @param [Hash] options additional configuration options for the button
    # @option options [String] :title appears when hovering over the button
    # @option options [String] :colour_classes TailwindCSS colour related classes to add
    # @option options [Hash] :icon see {IconsHelper} for more detail
    # @option options [Hash] :data Stimulus related data attributes.
    #   `action` is a [String] with each action separated by a space, `params` are a [Hash] with a `name` and `value`
    # @example With Stimulus events and parameters
    #   Button::Component.new(
    #     id: :toggle,
    #     label: 'Toggle',
    #     options: { action: 'click->editor#toggle', params: { name: 'editor-id', value: 1 } }
    #   )
    # @example With an icon
    #   Button::Component.new(
    #     id: :delete,
    #     label: 'Delete',
    #     options: { icon: { name: :trash, colour: :white } }
    #   )
    # @todo Encapsulate the icon and data hashes into their own objects.
    #   This would clean up this nebulous options hash somewhat.
    def initialize(id:, label:, options: {})
      super
      @id = id
      @label = label
      @options = options
    end
  end
end
