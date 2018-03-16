def create_dummy_class
  Class.new do
    extend ActiveNavision::ConnectionHandling
    extend ActiveNavision::QueryHandling
  end
end

shared_context 'query_context' do
  subject { create_dummy_class }
  let(:service_url) { 'http://example.com' }
  let(:filter) { ActiveNavision::Filter.new('Partner_ID', 'S*').filters }
  let(:mapping_keys) { %i[read_multiple_result read_multiple_result partner01_item] }
  let(:message) { build(:message, filter: filter, setSize: 1000).to_h }
  let(:second_message) { build(:message, filter: filter, setSize: 2).to_h }
  let(:third_message) { build(:message, filter: filter, bookmarkKey: 'key_5', setSize: 2).to_h }
  let(:response) { build :read_multiple_result, :default }
  let(:response_part1) { build :read_multiple_result, :part_1 }
  let(:response_part2) { build :read_multiple_result, :part_2 }

  before do
    SpreeNavConnector::Engine.configure {}
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
end
