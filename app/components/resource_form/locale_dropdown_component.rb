# frozen_string_literal: true

module ResourceForm
  class LocaleDropdownComponent < BaseComponent
    # @return [Boolean] true if the items list is hidden, false otherwise
    attr_reader :hidden

    def initialize(attribute:, label:, resource:, hidden: true, options: {})
      super(attribute: attribute, label: label, resource: resource, options: options)
      @hidden = hidden
    end

    private

    def locales
      supported_locales.map { |l| { text: l[:name], value: l[:alpha2], css: "fi fi-#{l[:flag]}" } }
    end

    def supported_locales
      [
        { name: 'English (GB)', alpha2: 'en-GB', flag: 'gb' },
        { name: 'English (US)', alpha2: 'en-US', flag: 'us' },
        { name: 'Thai', alpha2: 'th', flag: 'th' },
        { name: 'Chinese', alpha2: 'zh', flag: 'cn' }
      ]
    end
  end
end
