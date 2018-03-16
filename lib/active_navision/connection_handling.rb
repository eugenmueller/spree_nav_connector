require 'savon'

module ActiveNavision
  # connection handling module for navision
  module ConnectionHandling
    def client(options = {})
      @client ||= Savon::Client.new(options.merge(global_options))
    rescue Savon::InitializationError
      raise_initialization_error!
    end

    def multiple_result_mapping_keys(options = [])
      @multiple_result_mapping_keys ||= options
    end

    # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    def global_options
      {
        open_timeout:            config.open_timeout,
        read_timeout:            config.read_timeout,
        ssl_verify_mode:         config.ssl_verify_mode,
        ntlm:                    [config.username, config.password],
        convert_request_keys_to: config.convert_request_keys_to,
        namespace_identifier:    config.namespace_identifier,
        element_form_default:    config.element_form_default,
        env_namespace:           config.env_namespace,
        log:                     config.log,
        log_level:               config.log_level,
        pretty_print_xml:        config.pretty_print_xml
      }
    end
    # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

    def operations(*operations)
      operations.each { |operation| create_method(operation) }
    end

    private

    def config
      SpreeNavConnector::Engine.config
    end

    def create_method(method_name)
      define_singleton_method method_name.to_s.snakecase do |message|
        if message.present?
          client.call method_name.to_sym, message
        else
          client.call method_name.to_sym
        end
      end
    end

    def raise_initialization_error!
      raise InitializationError, error_message
    end

    def error_message
      %q(
        "Expected the model to be initialized with either a WSDL document or
        the SOAP endpoint and target namespace options.\n"\
        "Make sure to setup the model by calling the .client class method before
         calling the .global method.\n\n" \
        "client(wsdl: '/Users/me/project/service.wsdl')
        # to use a local WSDL document\n" \
        "client(wsdl: 'http://example.com?wsdl')
        # to use a remote WSDL document\n" \
        "client(endpoint: 'http://example.com',
        namespace: 'http://v1.example.com')
        # if you don't have a WSDL document"
      )
    end
  end
end
