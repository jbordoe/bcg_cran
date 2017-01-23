require_relative '../../../../apps/web/views/packages/index'

RSpec.describe Web::Views::Packages::Index do
  let(:exposures) { Hash[packages: 'bar'] }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/packages/index.html.erb') }
  let(:view)      { described_class.new(template, exposures) }
  let(:rendered)  { view.render }

  it 'exposes #packages' do
    expect(view.packages).to eq exposures.fetch(:packages)
  end

  context '#package_text' do
    it 'generates html for package' do
      package = double(name: 'foobar', version: '1.2.3')
      expect(view.package_text(package)).to eq '<b>foobar</b> v1.2.3'
    end
  end
end
