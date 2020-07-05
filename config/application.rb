require_relative 'boot'

require "rails"
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"

Bundler.require(*Rails.groups)

module Cocchi
  class Application < Rails::Application
    config.load_defaults 6.0

    config.time_zone = 'Central America'
    config.i18n.load_path +=
      Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
    config.i18n.enforce_available_locales = true

    config.assets.initialize_on_precompile = false
    config.public_file_server.enabled = true
    config.read_encrypted_secrets = true

    config.generators do |g|
      g.template_engine :slim

      g.test_framework nil
      g.factory_bot false

      g.javascripts false
      g.stylesheets false
      g.helper false
      g.assets false
      g.jbuilder false
    end
  end
end
