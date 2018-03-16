module ActiveNavision
  # Active Navision Base class
  class Base
    extend ConnectionHandling
    extend QueryHandling

    def self.filter
      @filter ||= ActiveNavision::Filter.new(config.partner_id).filters.first
    end
  end
end
