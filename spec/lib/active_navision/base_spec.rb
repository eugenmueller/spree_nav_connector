require 'spec_helper'

describe ActiveNavision::Base do
  subject { described_class }
  let(:config) { SpreeNavConnector::Engine.config }
  let(:filter) { ActiveNavision::Filter.new(config.partner_id).filters.first }

  it { is_expected.to respond_to :client }
  it { is_expected.to respond_to :find_in_batches }
  it { is_expected.to respond_to :config }
  it { is_expected.to respond_to :filter }
  it { is_expected.to respond_to :multiple_result_mapping_keys }
  it { expect(subject.config).to be_equal(config) }
  it { expect(subject.filter).to include(filter) }
end
