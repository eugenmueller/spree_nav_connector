# import items service
class ImportNavisionItems < BaseImporter
  nav_connector_model NavConnector::Item
  spree_navision_model Spree::NavisionItem

  def call
    import_all
  end

  # private

  # def import_items
  #   Spree::NavisionItem.transaction do
  #     # default batch_size 1000
  #     NavConnector::Item.find_in_batches do |group|
  #       group.each { |raw_item| create_or_update_item(raw_item) }
  #     end
  #   end
  # rescue StandardError => exception
  #   OpenStruct.new(success?: false, error: exception)
  # else
  #   OpenStruct.new(success?: true, error: nil)
  # end

  # def create_or_update_item(item)
  #   sliced_attributes = item.slice(*model_attributes)

  #   Spree::NavisionItem.update_or_create_by(
  #     { no: sliced_attributes[:no] },
  #     sliced_attributes
  #   )
  # end

  # def model_attributes
  #   @model_attributes ||= Spree::NavisionItem.attribute_names.map(&:to_sym)
  # end
end
