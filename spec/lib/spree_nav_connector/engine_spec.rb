require 'spec_helper'

describe SpreeNavConnector::Engine do
  subject { described_class.config }
  let(:username) { 'john doe' }
  let(:base_wsdl_url) { 'http://example.com' }
  let(:item_service_name) { 'page/partner01_item' }
  let(:log_level) { :debug }

  include_context 'engine_configuration'

  context 'savon configuration' do
    it { is_expected.to respond_to(:open_timeout) }

    %i[username password].each do |attr|
      it { is_expected.to respond_to(attr) }
      it { expect(subject.send(attr)).to eq(username) }
    end

    it { expect(subject.log_level).to eq log_level }
    it { expect(subject.convert_request_keys_to).to eq :none }
  end

  context 'webservice endpoint configuration' do
    it { is_expected.to respond_to(:base_wsdl_url) }
    it { expect(subject.base_wsdl_url).to eq(base_wsdl_url) }
  end

  context 'webservice endpoint services' do
    it { is_expected.to respond_to(:item_service) }
    it { expect(subject.item_service).to eq(item_service_name) }
  end

  describe '#setup' do
    it { expect { |b| described_class.setup(&b) }.to yield_with_args }
  end
end
