require 'spec_helper'

describe SpreeNavConnector::Engine do
  subject { described_class.config }
  let(:username) { 'john doe' }
  let(:base_wsdl_url) { 'http://example.com' }
  let(:item_service_name) { 'page/partner01_item' }
  let(:log_level) { :debug }

  before do
    described_class.configure do |config|
      config.username      = username
      config.password      = username
      config.base_wsdl_url = base_wsdl_url
      config.item_service  = item_service_name
      config.log_level     = log_level
    end
  end

  it { is_expected.to respond_to(:open_timeout) }

  context 'savon configuration' do
    %i[username password].each do |attr|
      it { is_expected.to respond_to(attr) }
      it { expect(subject.send(attr)).to eq(username) }
    end

    it { expect(subject.log_level).to eq log_level}
  end

  context 'webservice endpoint configuration' do
    it { is_expected.to respond_to(:base_wsdl_url) }
    it { expect(subject.base_wsdl_url).to eq(base_wsdl_url) }
  end

  context 'webservice endpoint services' do
    it { is_expected.to respond_to(:item_service) }
    it { expect(subject.item_service).to eq(item_service_name) }
  end
end
