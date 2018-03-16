module ActiveNavision
  class Error < RuntimeError; end
  class InitializationError < Error; end
  # Generic Active Navision exception class.
  class ActiveNavisionError < StandardError; end

  # Raised when Active Navision cannot find a recor by given key
  class RecordNotFound < ActiveNavisionError
    attr_reader :service_url, :relation, :message

    def initialize(service_url = nil, relation = nil, message = nil)
      @service_url = service_url
      @relation = relation
      @message = message

      super(build_error_message)
    end

    def build_error_message
      "#{@service_url}: #{@relation} #{@message}"
    end
  end
end
