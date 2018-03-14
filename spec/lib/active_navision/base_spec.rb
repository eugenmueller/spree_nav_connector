require 'spec_helper'

describe ActiveNavision::Base do
  subject { described_class }
  it { is_expected.to respond_to :client }
  it { is_expected.to respond_to :find_in_batches }
end
