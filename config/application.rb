require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Context
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    config.time_zone = "Moscow"
    # config.eager_load_paths << Rails.root.join("extras")
    config.i18n.default_locale = :ru

    # Disable field_with_errors <div>
    config.action_view.field_error_proc = Proc.new{ |html_tag, instance| "#{html_tag}".html_safe }
  end
end