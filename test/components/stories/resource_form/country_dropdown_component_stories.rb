# frozen_string_literal: true

module ResourceForm
  class CountryDropdownComponentStories < ApplicationStories
    story :basic do
      constructor(
        attribute: 'country_alpha2',
        label: 'Country',
        resource: klazz(User),
        options: { readonly: false }
      )
    end

    story :readonly do
      constructor(
        attribute: 'country_alpha2',
        label: 'Country',
        resource: klazz(User, country_alpha2: 'AU'),
        options: { readonly: true }
      )
    end

    story :selected do
      constructor(
        attribute: 'country_alpha2',
        label: 'Country',
        resource: klazz(User, country_alpha2: 'AU'),
        hidden: false,
        options: { readonly: false }
      )
    end
  end
end
