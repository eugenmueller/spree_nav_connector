require 'spec_helper'

describe ActiveNavision::QueryHandling do
  include_context 'query_context'

  it { is_expected.to respond_to :find_in_batches }

  describe '#find_in_batches' do
    before do
      @batch_runs = 0
      subject.find_in_batches(filter: message[:filter], batch_size: size) do |group|
        @batch_runs += 1
        group.each do |i|
          result << i
        end
      end
    end

    context 'yield results with default size' do
      let(:size) { 1000 }
      let(:result) { [] }

      it { expect(result.size).to be(3) }
      it { expect(@batch_runs).to be(1) }
    end

    context 'yield result with size of 2' do
      let(:size) { 2 }
      let(:result) { [] }

      it { expect(result.size).to be(3) }
      it { expect(@batch_runs).to be(2) }
    end
  end
end
