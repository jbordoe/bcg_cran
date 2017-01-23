RSpec.describe Person do
  it 'can be initialized with attributes' do
    person = Person.new(name: 'Foo Bar', email: 'foo@bar.org')

    expect(person.name).to eq 'Foo Bar'
    expect(person.email).to eq 'foo@bar.org'
    expect(person.to_s).to eq 'Foo Bar <foo@bar.org>'
  end

  it 'can be initialized from a string' do
    person = Person.new_from_string('Bar Baz <bar@baz.net>')

    expect(person.name).to eq 'Bar Baz'
    expect(person.email).to eq 'bar@baz.net'
    expect(person.to_s).to eq 'Bar Baz <bar@baz.net>'
  end
end
