require 'spec_helper'

describe ImportNavisionItems do
  subject { described_class }

  describe '#call' do
    let(:response) { build(:read_multiple_result, :default) }
    let(:empty_response) { build(:read_multiple_empty_result) }
    let(:result) { subject.call }

    shared_examples 'empty_call_result' do
      it { expect(result.success?).to be_falsy }
      it { expect(result.error).to be_a_kind_of ActiveNavision::RecordNotFound }
    end

    context 'successfull call' do
      before do
        allow(NavConnector::Item).to receive(:read_multiple)
          .with(anything)
          .and_return(response)
      end

      it { expect(result).to respond_to :success? }
      it { expect(result.success?).to be_truthy }
      it { expect(result.error).to be_nil }
      it { expect { result }.to change { Spree::NavisionItem.count }.to(3) }
    end

    context 'successfull call with empty result' do
      before do
        allow(NavConnector::Item).to receive(:read_multiple)
          .with(anything)
          .and_return(empty_response)
      end

      it_behaves_like 'empty_call_result'
    end

    context 'errorfull call' do
      before do
        allow(NavConnector::Item).to receive(:read_multiple)
          .with(anything)
          .and_return('foo')
      end

      it_behaves_like 'empty_call_result'
    end
  end
end
