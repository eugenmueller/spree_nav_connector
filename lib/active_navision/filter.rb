module ActiveNavision
  # Filter class for Navision SOAP requests
  class Filter
    attr_reader :filters

    def initialize(field, criteria)
      @filters = {}
      add_filter(:field, field)
      add_filter(:Criteria, criteria)
    end

    def add_filter(key, value)
      @filters[key] = value
      @filters
    end
  end
end
