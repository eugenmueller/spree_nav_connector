
module Spree
  # persistence module
  module Persistence
    def self.included(klass)
      klass.extend(ClassMethods)
    end

    # persistence class methods
    module ClassMethods
      def update_or_create_by(args, attributes)
        obj = find_or_create_by(args)
        obj.update(attributes)
      end
    end
  end
end
