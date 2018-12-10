require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
# require "active_record/railtie"
# require "active_storage/engine"
require "action_controller/railtie"
# require "action_mailer/railtie"
require "action_view/railtie"
# require "action_cable/engine"
# require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module HealthUnitApi
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # locales & encoding
    config.time_zone = 'Brasilia'
    config.encoding = 'utf-8'
    config.i18n.default_locale = 'pt-br'
    config.i18n.fallbacks = [:en]

    # paths
    config.autoload_paths += Dir["#{Rails.root}/app/**/**/*.rb"]
    config.eager_load_paths += Dir["#{Rails.root}/app/**/**/*.rb"]
    config.autoload_paths += Dir["#{Rails.root}/lib/**/**/**"]
    config.eager_load_paths += Dir["#{Rails.root}/lib/**/**/*.rb"]
    config.generators.system_tests = nil
    config.api_only = true
  end
end
