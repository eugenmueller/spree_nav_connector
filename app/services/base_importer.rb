# Baser Importer class methods
module ClassMethods
  def call
    new.call
  end

  def nav_connector_model(model)
    @nav_connector_model = model
  end

  def spree_navision_model(model)
    @spree_navision_model = model
  end

  def import_all
    @spree_navision_model.transaction do
      @nav_connector_model.find_in_batches(filter: filter) do |group|
        group.each { |raw_item| create_or_update_item(raw_item) }
      end
    end
  rescue StandardError => exception
    OpenStruct.new(success?: false, error: exception)
  else
    OpenStruct.new(success?: true, error: nil)
  end

  def create_or_update_item(item)
    sliced_attributes = item.slice(*model_attributes)

    @spree_navision_model.update_or_create_by(
      { no: sliced_attributes[:no] },
      sliced_attributes
    )
  end

  def model_attributes
    @model_attributes ||= @spree_navision_model.attribute_names.map(&:to_sym)
  end

  def filter
    @nav_connector_model.filter
  end
end

# base importer instance methods
module InstanceMethods
  def import_all
    self.class.import_all
  end
end

# Base importer class
class BaseImporter
  extend ClassMethods
  include InstanceMethods
end
