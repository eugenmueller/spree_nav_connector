require 'spec_helper'

describe SpreeNavConnector::Configuration do
  subject { described_class.new }

  it { is_expected.to respond_to(:username) }
  it { is_expected.to respond_to(:password) }
  it { is_expected.to respond_to(:log_level) }
  it { is_expected.to respond_to(:base_wsdl_url) }
end
