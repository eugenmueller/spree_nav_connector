require 'spec_helper'

describe ActiveNavision::Filter do
  let(:filter) { { field: 'Partner_ID', Criteria: 'S*' } }
  subject { described_class.new('S*') }

  it { is_expected.to respond_to :filters }
  it { expect(subject.filters).to be_a_kind_of Array}
  it { expect(subject.filters.first).to include(filter) }

  describe '#add_filter' do
    before { subject.add_filter('foo', 'bar') }

    it { expect(subject.filters).to include(field: 'foo', Criteria: 'bar') }
    it { expect(subject.add_filter('bla', 'blub')).to eql(subject.filters) }
  end
end
