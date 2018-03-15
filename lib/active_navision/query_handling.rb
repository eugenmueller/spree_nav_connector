require 'savon'

module ActiveNavision
  # query hanlding for active navision
  module QueryHandling
    def find_in_batches(start_key: nil, batch_size: 1000, filter: {})
      batch_relation = self
      key_offset     = start_key || ''
      loop do
        message = build_message(filter, key_offset, batch_size)
        results = load_flat_multiple_results(batch_relation, message)
        break if results.empty?

        yield results

        break if results.length < batch_size

        key_offset = results.last[:key]
      end
    end

    private

    def load_flat_multiple_results(relation, message)
      response = relation.read_multiple(message: message)
      response.body.dig(*relation.multiple_result_mapping_keys)
    rescue StandardError
      raise_navision_record_not_found_exception!
    end

    def build_message(filter, key, size)
      {
        filter:      filter,
        bookmarkKey: key,
        setSize:     size
      }
    end

    def raise_navision_record_not_found_exception!
      raise ActiveNavision::NavisionRecordNotFound.new('error', self.class, 'key todo')
    end
  end
end
