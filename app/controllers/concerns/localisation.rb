# frozen_string_literal: true

# Apply i18n settings
module Localisation
  extend ActiveSupport::Concern

  included do
    around_action :use_locale
  end

  private

  def use_locale(&action)
    locale = current_user&.locale || I18n.default_locale
    I18n.with_locale(locale, &action)
  end
end
