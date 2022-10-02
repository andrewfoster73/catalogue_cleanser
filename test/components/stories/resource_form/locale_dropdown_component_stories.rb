# frozen_string_literal: true

module ResourceForm
  class LocaleDropdownComponentStories < ApplicationStories
    story :basic do
      constructor(
        attribute: 'locale',
        label: 'Locale',
        resource: klazz(User),
        options: { readonly: false }
      )
    end

    story :readonly do
      constructor(
        attribute: 'locale',
        label: 'Locale',
        resource: klazz(User),
        options: { readonly: true }
      )
    end

    story :selected do
      constructor(
        attribute: 'locale',
        label: 'Locale',
        resource: klazz(User, locale: 'en-GB'),
        options: { readonly: false }
      )
    end
  end
end
