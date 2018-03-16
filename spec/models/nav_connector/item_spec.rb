require 'spec_helper'

describe NavConnector::Item do
  subject { described_class }

  it_behaves_like 'an_active_navision_model', %i[read_multiple]
end
