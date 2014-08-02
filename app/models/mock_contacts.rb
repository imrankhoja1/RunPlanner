class MockContacts
  attr_accessor :first_name, :last_name, :phone

  def initialize(first_name, last_name, phone)
    self.first_name = first_name
    self.last_name = last_name
    self.phone = phone
  end

  def self.mock
    contacts = []
    contacts << new("Imran", "Khoja", "555-555-5555")
    contacts << new("Emily", "Little", "555-555-5555")
    contacts << new("John", "Doe", "555-555-5555")
    contacts
  end
end
