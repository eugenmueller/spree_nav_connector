module ActiveNavision
  # Filter class for Navision SOAP requests
  class Filter
    attr_reader :filters

    def initialize(partner_id)
      @filters = []
      add_partner_id(partner_id)
    end

    def add_filter(field, criteria)
      @filters << { field: field, Criteria: criteria }
    end

    private

    def add_partner_id(id)
      add_filter('Partner_ID', id)
    end
  end
end
