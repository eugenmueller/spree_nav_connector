require 'savon'

module ActiveNavision
  # query hanlding for active navision
  module QueryHandling

    def find_in_batches(batch_size: 1000, filter: {})
      @key_offset = ''

      loop do
        @message = build_message(filter, @key_offset, batch_size)
        @results = load_flat_multiple_results(self, @message)

        break if @results.empty?

        yield @results

        @key_offset = ''

        break if @results.length < batch_size

        @key_offset = @results.last[:key]
      end
    end

    private

    def load_flat_multiple_results(relation, message)
      @response = relation.read_multiple(message: message)
      @response.body.dig(*relation.multiple_result_mapping_keys)
    rescue StandardError
      raise_navision_record_not_found_exception!(message)
    end

    def build_message(filter, key, size)
      {
        filter:      filter,
        bookmarkKey: key,
        setSize:     size
      }
    end

    def raise_navision_record_not_found_exception!(message)
      raise RecordNotFound.new('error', self, message)
    end
  end
end
