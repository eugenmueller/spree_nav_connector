require 'spec_helper'

describe Spree::NavisionItem, type: :model do
  context 'has a valid factory' do
    it { expect(create(:spree_navision_item)).to be_truthy }
  end

  describe '#update_or_create_by' do
    let(:item) do
      build(:raw_navision_item).to_h.slice(
        *Spree::NavisionItem.attribute_names.map(&:to_sym)
      )
    end

    before { described_class.update_or_create_by({ no: item[:no] }, item) }

    it { expect(described_class).to respond_to :update_or_create_by }
    it { expect(described_class.count).to be(1) }
    it 'update available item' do
      expect { described_class.update_or_create_by({ no: item[:no] }, item) }
        .not_to change { described_class.count }
    end
  end

  describe 'Validation' do
    it 'is valid with valid attributes' do
      expect(build(:spree_navision_item)).to be_valid
    end

    it 'is invalid without a no' do
      expect(build(:spree_navision_item, no: nil)).not_to be_valid
    end

    it 'is invalid without a rec_id' do
      expect(build(:spree_navision_item, rec_id: nil)).not_to be_valid
    end

    context 'key validation' do
      let(:key) { '12345_ab' }

      before { create(:spree_navision_item, key: key) }

      it 'is invalid without a key' do
        expect(build(:spree_navision_item, key: nil)).not_to be_valid
      end

      it 'is invalid without a unique key' do
        expect(build(:spree_navision_item, key: key)).not_to be_valid
      end
    end
  end
end
