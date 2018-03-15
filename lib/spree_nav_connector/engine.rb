module SpreeNavConnector
  # Engines main class
  class Engine < Rails::Engine
    require 'spree/core'
    require 'virtus'
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
      attr_reader :config

      def configure
        @config = SpreeNavConnector::Configuration.new
        yield config
      end
    end

    def self.setup(&_block)
      yield self
    end
  end
end
