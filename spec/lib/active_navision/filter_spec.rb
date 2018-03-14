require 'spec_helper'

describe ActiveNavision::Filter do
  subject { described_class.new('Partner_ID', 'S*') }

  it { is_expected.to respond_to :filters }
  it { expect(subject.filters).to include(field: 'Partner_ID') }
  it { expect(subject.filters).to include(Criteria: 'S*') }

  describe '#add_filter' do
    before { subject.add_filter(:foo, 'bar') }

    it { expect(subject.filters).to include(foo: 'bar') }
    it { expect(subject.add_filter(:bla, 'blub')).to eql(subject.filters) }
  end
end
