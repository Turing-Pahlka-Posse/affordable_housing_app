require File.expand_path('../boot', __FILE__)

require "rails"
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
Bundler.require(*Rails.groups)

module AffordableHousingApp
  class Application < Rails::Application
    config.active_record.raise_in_transactional_callbacks = true

    config.after_initialize do |app|
      app.config.paths.add 'app/services', :eager_load => true
    end
  end
end

ENV['SSL_CERT_FILE'] = Gem.loaded_specs['google-api-client'].full_gem_path+'/lib/cacerts.pem'