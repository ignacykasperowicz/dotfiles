require File.expand_path('../boot', __FILE__)

require 'rails/all'
require 'active_support/core_ext/digest/uuid'

ROADIE_I_KNOW_ABOUT_VERSION_3 = true

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module DurstPortal
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'America/New_York'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    I18n.enforce_available_locales = true
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    config.autoload_paths += [
      "#{config.root}/lib",
      "#{config.root}/app/lib",
      "#{config.root}/app/settings",
      "#{config.root}/app/operations",
      "#{config.root}/app/queries",
    ]
    config.active_job.queue_adapter = :delayed_job

    config.action_controller.action_on_unpermitted_parameters = :raise
  end
end
