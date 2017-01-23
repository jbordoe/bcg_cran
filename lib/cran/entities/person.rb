class Person < Hanami::Entity
  def self.new_from_string(str)
    match = str.match /([^<]+)\s?(<(\w+@\w+\.\w+)>)?/
    name  = match[1].chop
    email = match[3]

    Person.new(name: name, email: email)
  end

  def to_s
    str = name
    str += " <#{email}>" if email
    str
  end
end
