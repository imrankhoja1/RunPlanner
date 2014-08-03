class Contact
  attr_accessor :first_name, :last_name, :phones
  attr_accessor :state

  def initialize(first_name, last_name, phones)
    @first_name = first_name
    @last_name = last_name
    @phones = phones

    @state = :unselected
  end

  def toggle
    @state == :selected ? unselect : select
  end

  def select
    @state = :selected
  end

  def unselect
    @state = :unselected
  end

  def self.mock_list
    contacts = []
    contact = new("Imran", "Khoja", [{ value: "1 (617) 899-3929" }])
    contact.select
    contacts << contact
    contact = new("Emily", "Little", [{ value: "555-555-5555" }])
    contact.select
    contacts << contact
    contact = new("Ben", "Miller", [{ value: "1 (617) 230-2397" }])
    contact.select
    contacts << contact
    contacts << new("John", "Doe", [{ value: "555-555-5555" }])
    contacts << new("Abigale", "Doe", [{ value: "555-555-5555" }])
    contacts << new("Bob", "Doe", [{ value: "555-555-5555" }])
    contacts << new("Cole", "Doe", [{ value: "555-555-5555" }])
    contacts
  end
end
