# operations
shared_examples 'an_active_navision_model' do |operations|
  it { is_expected.to be < ActiveNavision::Base }

  describe '#client' do
    it { is_expected.to respond_to(:client) }
    it { expect(subject.client).to be_a_kind_of Savon::Client }
  end

  describe '#config' do
    it { is_expected.to respond_to(:config) }
  end

  describe '#operations' do
    it { is_expected.to respond_to(:operations) }

    operations.each do |operation|
      it { is_expected.to respond_to operation }
    end
  end

  describe '#multiple_result_mapping_keys' do
    it { is_expected.to respond_to :multiple_result_mapping_keys }
    it { expect(subject.multiple_result_mapping_keys).not_to be_empty }
  end

  describe '#find_in_batches' do
    it { is_expected.to respond_to :find_in_batches }
  end
end
