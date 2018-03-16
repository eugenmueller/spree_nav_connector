SpreeNavConnector::Engine.configure do |config|
  # Set this options to what makes sense for you
  # Savon global configuration => http://savonrb.com/version2/globals.html
  # Example: config.option = 'different_option'
  config.open_timeout            = 5
  config.read_timeout            = 120
  config.username                = 'username'
  config.password                = 'password'
  config.element_form_default    = :unqualified
  config.env_namespace           = :soap
  config.namespace_identifier    = nil
  config.convert_request_keys_to = :none
  config.log                     = false
  config.log_level               = :debug
  config.pretty_print_xml        = true
end
