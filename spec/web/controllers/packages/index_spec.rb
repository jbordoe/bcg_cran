require_relative '../../../../apps/web/controllers/packages/index'

RSpec.describe Web::Controllers::Packages::Index do
  let(:action) { described_class.new }
  let(:params) { Hash[] }
  let(:dummy_repo) {
    double(all: [1,2,3])
  }

  it 'is successful' do
    expect(PackageRepository).to receive(:new) { dummy_repo }

    response = action.call(params)
    expect(response[0]).to eq 200
    expect(action.exposures[:packages]).to eq([1,2,3])
  end
end
