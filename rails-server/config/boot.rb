ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' # Set up gems listed in the Gemfile.
require 'rails/commands/server'

module Rails
  class Server
    def default_options
      super.merge({Port: 5000, Host: '0.0.0.0'})
    end
  end
end
