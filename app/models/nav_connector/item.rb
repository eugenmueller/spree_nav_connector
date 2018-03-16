module NavConnector
  class Item < ActiveNavision::Base
    # configuration
    client wsdl: "#{config.base_wsdl_url}/#{config.item_service}"

    operations :read_multiple

    multiple_result_mapping_keys %i[read_multiple_result
                                    read_multiple_result
                                    partner01_item]
    # service methods
  end
end
