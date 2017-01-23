RSpec.describe Package do
  let(:maintainer) {
    Person.new(name: 'Michael Blum', email: 'michael.blum@imag.fr')
  }
  let(:authors) {
    'Christian Panse <cp@fgcz.ethz.ch>, Jonas Grossmann <jg@fgcz.ethz.ch>'
  }

  it 'can be initialized with attributes' do
    package = Package.new(
      name: 'abc',
      version: '1.6',
      date: DateTime.now,
      description: 'The package implements several ABC algorithms',
      authors: authors,
      maintainer: maintainer
    )

    expect(package.name).to eq 'abc'
    expect(package.version).to eq'1.6'
    expect(package.maintainer).to eq('Michael Blum <michael.blum@imag.fr>')
    expect(package.authors).to eq(authors)
  end
end
