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

    # rubocop:disable Metrics/MethodLength
    def global_options
      {
        open_timeout:            SpreeNavConnector::Engine.open_timeout,
        read_timeout:            SpreeNavConnector::Engine.read_timeout,
        ssl_verify_mode:         SpreeNavConnector::Engine.ssl_verify_mode,
        ntlm:                    [
          SpreeNavConnector::Engine.username,
          SpreeNavConnector::Engine.password
        ],
        convert_request_keys_to: SpreeNavConnector::Engine.request_keys_to,
        namespace_identifier:    SpreeNavConnector::Engine.namespace_identifier,
        element_form_default:    SpreeNavConnector::Engine.element_form_default,
        env_namespace:           SpreeNavConnector::Engine.env_namespace,
        log:                     SpreeNavConnector::Engine.log,
        log_level:               SpreeNavConnector::Engine.log_level,
        pretty_print_xml:        SpreeNavConnector::Engine.pretty_print_xml
      }
    end
    # rubocop:enable Metrics/MethodLength

    def operations(*operations)
      operations.each do |operation|
        create_method(operation)
      end
    end

    private

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
