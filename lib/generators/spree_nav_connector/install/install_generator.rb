module SpreeNavConnector
  module Generators
    # Install generator class
    class InstallGenerator < Rails::Generators::Base
      class_option :auto_run_migrations, type: :boolean, default: false
      source_root File.expand_path('../../templates', __dir__)

      def add_javascripts
        append_file 'vendor/assets/javascripts/spree/frontend/all.js',
                    "//= require spree/frontend/spree_nav_connector\n"
        append_file 'vendor/assets/javascripts/spree/backend/all.js',
                    "//= require spree/backend/spree_nav_connector\n"
      end

      def add_stylesheets
        inject_into_file 'vendor/assets/stylesheets/spree/frontend/all.css',
                         " *= require spree/frontend/spree_nav_connector\n",
                         before: %r{\*\/},
                         verbose: true
        inject_into_file 'vendor/assets/stylesheets/spree/backend/all.css',
                         " *= require spree/backend/spree_nav_connector\n",
                         before: %r{\*\/},
                         verbose: true
      end

      def add_migrations
        run %(
          bundle exec rake railties:install:migrations FROM=spree_nav_connector
        )
      end

      def run_migrations
        # rubocop:disable Style/NestedParenthesizedCalls, Metrics/LineLength
        run_migrations = options[:auto_run_migrations] || ['', 'y', 'Y'].include?(ask 'Would you like to run the migrations now? [Y/n]')
        # rubocop:enable Style/NestedParenthesizedCalls, Metrics/LineLength
        if run_migrations
          run 'bundle exec rake db:migrate'
        else
          puts 'Skipping rake db:migrate, don\'t forget to run it!'
        end
      end

      desc 'Creates SpreNavConnector initializer for your application'
      def copy_initializer
        template 'default_initializer.rb',
                 'config/initializers/spree_nav_connector.rb'

        puts 'Initializer for spree_nav_connector created!'
      end
    end
  end
end
