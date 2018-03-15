module SpreeNavConnector
  # Engines main class
  class Engine < Rails::Engine
    require 'spree/core'
    isolate_namespace Spree
    engine_name 'spree_nav_connector'

    config.autoload_paths += %W[#{config.root}/lib #{config.root}/app/services]

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
      g.fixture_replacement :factory_bot
      g.factory_bot dir: 'spec/factories'
    end

    def self.activate
      file = File.join(File.dirname(__FILE__), '../../app/**/*_decorator*.rb')
      Dir.glob(file) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end

    config.to_prepare(&method(:activate).to_proc)

    class << self
      mattr_accessor :open_timeout
      mattr_accessor :read_timeout
      mattr_accessor :ssl_verify_mode
      mattr_accessor :username, :password
      mattr_accessor :element_form_default
      mattr_accessor :env_namespace
      mattr_accessor :namespace_identifier
      mattr_accessor :request_keys_to
      mattr_accessor :log
      mattr_accessor :log_level
      mattr_accessor :pretty_print_xml

      # set defaults
      self.open_timeout = 5
      self.read_timeout = 120
      self.ssl_verify_mode = :none
      self.username = 'username'
      self.password = 'password'
      self.element_form_default = :unqualified
      self.env_namespace = :soap
      self.namespace_identifier = nil
      self.request_keys_to = :none
      self.log = false
      self.log_level = :debug
      self.pretty_print_xml = true
    end

    def self.setup(&_block)
      yield self
    end
  end
end
