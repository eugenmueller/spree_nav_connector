require 'spec_helper'

class TestService < BaseImporter
end

describe BaseImporter do
  subject { TestService.new }

  it { is_expected.to be_a_kind_of(described_class) }
  it { expect(TestService).to respond_to :call }
  it { expect(TestService).to respond_to :nav_connector_model }
  it { expect(TestService).to respond_to :spree_navision_model }
  it { expect(TestService).to respond_to :import_all }
  it { expect(TestService).to respond_to :create_or_update_item }
  it { expect(TestService).to respond_to :model_attributes }
end
