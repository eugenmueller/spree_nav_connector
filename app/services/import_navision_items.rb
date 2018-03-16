# import items service
class ImportNavisionItems < Base
  def call
    import_items
  end

  private

  def initialize(*)
    @attribute_names ||= Spree::NavisionItem.attribute_names.map(&:to_sym)
  end

  def import_items
    Spree::NavisionItem.transaction do
      # default batch_size 1000
      NavConnector::Item.find_in_batches do |group|
        group.each { |raw_item| create_or_update_item(raw_item) }
      end
    end
  rescue StandardError => exception
    OpenStruct.new(success?: false, error: exception)
  else
    OpenStruct.new(success?: true, error: nil)
  end

  def create_or_update_item(item)
    sliced_item = item.slice(*Spree::NavisionItem.attribute_names.map(&:to_sym))

    Spree::NavisionItem.update_or_create_by(
      { no: sliced_item[:no] },
      sliced_item
    )

    # if navision_item.save!
    #   Rails.logger.info(
    #     %(NavisionItem with Number: #{navision_item.no} imported!
    #       => (New: #{navision_item.id}))
    #   )
    # else
    #   Rails.logger.error "Error: #{navision_item.error.messages}, #{item}"
    # end
  end
end
