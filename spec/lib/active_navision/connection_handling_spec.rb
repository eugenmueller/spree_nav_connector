require 'spec_helper'

describe ActiveNavision::ConnectionHandling do
  let(:service_url) { 'http://example.com' }
  subject { Class.new { extend ActiveNavision::ConnectionHandling } }

  before { SpreeNavConnector::Engine.configure {} }

  it { is_expected.to respond_to :client }

  describe '#client' do
    context 'with service url' do
      before { subject.client(wsdl: service_url) }

      it { expect(subject.client).to be_kind_of(Savon::Client) }
      it { expect(subject.client.globals[:wsdl]).to eql(service_url) }
    end

    context 'without servie url' do
      it { expect { subject.client }.to raise_error ActiveNavision::InitializationError }
    end
  end

  describe '#global_options' do
    expected_keys = %i[
      open_timeout read_timeout ssl_verify_mode ntlm convert_request_keys_to
      namespace_identifier element_form_default env_namespace log log_level
      pretty_print_xml
    ]

    expected_keys.each do |key|
      it { expect(subject.global_options).to include key }
    end

    it { expect(subject.global_options).not_to include :wsdl }
  end

  describe '#operations' do
    before { subject.operations :some_test_operation }

    it { expect(subject).to respond_to :some_test_operation }

    context 'some_test_operation' do
      let(:my_object) { subject }
      let(:message) { { filter: '123' } }

      it 'send a client call with message' do
        expect(my_object).to receive_message_chain(:client, :call).with(:some_test_operation, message)
        my_object.some_test_operation message
      end

      it 'send a client call with empty message' do
        expect(my_object).to receive_message_chain(:client, :call).with(:some_test_operation)
        my_object.some_test_operation nil
      end
    end
  end

  describe '#multiple_result_mapping_keys' do
    before { subject.client(wsdl: service_url) }
    before { subject.multiple_result_mapping_keys(%i[a b]) }

    it { expect(subject).to respond_to :multiple_result_mapping_keys }
    it { expect(subject.multiple_result_mapping_keys).to eq %i[a b] }
  end
end
