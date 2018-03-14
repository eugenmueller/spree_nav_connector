module ActiveNavision
  # Generic Active Navision exception class.
  class ActiveNavisionError < StandardError
  end

  # Raised when Active Navision cannot find a recor by given key
  class NavisionRecordNotFound < ActiveNavisionError
    attr_reader :service_url, :nav_key, :primary_key

    def initialize(service_url = nil, nav_key = nil, primary_key = nil)
      @service_url = service_url
      @nav_id = nav_id
      @primary_key = primary_key

      super(message)
    end
  end
end
