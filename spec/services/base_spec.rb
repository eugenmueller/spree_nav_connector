require 'spec_helper'

class TestService < Base
end

describe Base do
  subject { TestService.new }

  it { is_expected.to be_a_kind_of(described_class) }
  it { expect(TestService).to respond_to :call }
end
