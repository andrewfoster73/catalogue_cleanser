# frozen_string_literal: true

module ResourceForm
  class CountryDropdownComponent < BaseComponent
    attr_reader :hidden

    def initialize(attribute:, label:, resource:, hidden: true, options: {})
      super(attribute: attribute, label: label, resource: resource, options: options)
      @hidden = hidden
    end

    private

    def countries
      supported_countries.map do |c|
        { text: c.iso_short_name, value: c.alpha2, css: "fi fi-#{c.alpha2.downcase}" }
      end
    end

    def supported_countries
      sorted_countries(subset_alpha2s: priority_country_alpha2s) |
        sorted_countries(subset_alpha2s: other_country_alpha2s)
    end

    def sorted_countries(subset_alpha2s:)
      ISO3166::Country.countries.select { |c| subset_alpha2s.include?(c.alpha2) }.sort_by(&:iso_short_name)
    end

    def priority_country_alpha2s
      %w[AU NZ TH SG GB]
    end

    def other_country_alpha2s
      %w[
        AE AS AT BE BG BR CA CH CN CY CZ DB DE DK ES FJ FR GH GI HK HU ID IE IL IN IT JM JO JP KH KR LA LK MA
        MO MU MV MY NL NO PG PH PL PT RU SA SE TR TW UA UM US VN VU ZA
      ]
    end
  end
end
