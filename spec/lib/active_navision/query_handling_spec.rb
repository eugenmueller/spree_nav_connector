require 'spec_helper'

describe ActiveNavision::QueryHandling do
  let(:service_url) { 'http://example.com' }
  let(:filter) { ActiveNavision::Filter.new('Partner_ID', 'S*').filters }
  let(:mapping_keys) { %i[read_multiple_result read_multiple_result partner01_item] }
  let(:message) { build(:message, filter: filter, setSize: 1000).to_h }
  let(:second_message) { build(:message, filter: filter, setSize: 2).to_h }
  let(:third_message) { build(:message, filter: filter, bookmarkKey: 'key_5', setSize: 2).to_h }
  let(:response) { build :read_multiple_result, :default }
  let(:response_part1) { build :read_multiple_result, :part_1 }
  let(:response_part2) { build :read_multiple_result, :part_2 }

  subject do
    Class.new do
      extend ActiveNavision::ConnectionHandling
      extend ActiveNavision::QueryHandling
    end
  end

  before do
    subject.client(wsdl: service_url)
    subject.operations :read_multiple
    subject.multiple_result_mapping_keys mapping_keys
    allow(subject).to receive(:read_multiple)
      .with(message: message)
      .and_return(response)
    allow(subject).to receive(:read_multiple)
      .with(message: second_message)
      .and_return(response_part1)
    allow(subject).to receive(:read_multiple)
      .with(message: third_message)
      .and_return(response_part2)
  end

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
