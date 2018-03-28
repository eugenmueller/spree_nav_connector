# import items service
class ImportNavisionItems < BaseImporter
  nav_connector_model NavConnector::Item
  spree_navision_model Spree::NavisionItem

  def call
    import_all
  end
end
