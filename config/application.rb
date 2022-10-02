# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

require 'view_component'
require 'view_component/storybook'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CatalogueCleanser
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults(7.0)

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # For component sidecar js
    initializer 'app_assets', after: 'importmap.assets' do
      Rails.application.config.assets.paths << Rails.root.join('app')
    end

    # Sweep importmap cache for components
    config.importmap.cache_sweepers << Rails.root.join('app/components')

    # I18n
    config.i18n.default_locale = 'en-GB'
    config.i18n.available_locales = %w[en-GB en-US th zh]
    config.i18n.raise_on_missing_translations = Rails.env.development?
    config.i18n.load_path += Dir[Rails.root.join('config/locales/**/*.{rb,yml}')]
    config.i18n.load_path += Dir[Rails.root.join('app/components/**/*.yml')]
  end
end
