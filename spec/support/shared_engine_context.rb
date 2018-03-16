shared_context 'engine_configuration' do
  before do
    SpreeNavConnector::Engine.configure do |config|
      config.username                = username
      config.password                = username
      config.base_wsdl_url           = base_wsdl_url
      config.item_service            = item_service_name
      config.log_level               = log_level
      config.convert_request_keys_to = :none
    end
  end
end
