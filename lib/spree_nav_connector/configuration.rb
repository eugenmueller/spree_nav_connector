module SpreeNavConnector
  # NavConnector configuration class provide default values
  class Configuration
    include Virtus.model
    # Savon configuration attributes
    attribute :open_timeout, Integer,            default: 5
    attribute :read_timeout, Integer,            default: 120
    attribute :ssl_verify_mode, Symbol,          default: :none
    attribute :username, String,                 default: 'username'
    attribute :password, String,                 default: 'password'
    attribute :element_form_default, Symbol,     default: :unqualified
    attribute :env_namespace, Symbol,            default: :soap
    attribute :namespace_identifier, String,     default: nil
    attribute :convert_request_keys_to, Symbol,  default: :none
    attribute :log, Boolean,                     default: false
    attribute :log_level, Symbol,                default: :debug
    attribute :pretty_print_xml, Boolean,        default: true

    # Webservice endpoint configuration attributes
    attribute :base_wsdl_url, String
    attribute :partner_id, String, default: 'S*'
    # Webservice endpoints
    attribute :item_service, String
  end
end
