class ContactList
  attr_accessor :contacts

  def initialize
    address_book = AddressBook::AddrBook.new
    @contacts = address_book.people.map do |x|
      Contact.new(x.first_name, x.last_name, x.phones)
    end
    @contacts = mock if @contacts.empty?
    NSLog("phone: %@", @contacts[0].phones[0][:value])
  end

  def tableView(table_view, numberOfRowsInSection:section)
    @contacts.size
  end

  def tableView(table_view, cellForRowAtIndexPath: index_path)
    row = index_path.row
    reuse_id = nil
    cell = table_view.dequeueReusableCellWithIdentifier(reuse_id) || begin
      UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier: reuse_id)
    end
    contact = ordered_contacts[row]
    if contact.state == :selected
      cell.accessoryType = UITableViewCellAccessoryCheckmark
    end
    cell.textLabel.text = "#{contact.first_name} #{contact.last_name}"
    cell
  end

  def tableView(table_view, didSelectRowAtIndexPath: index_path)
    cell = table_view.cellForRowAtIndexPath(index_path)

    contact = ordered_contacts[index_path.row]
    contact.toggle

    table_view.beginUpdates
    ip = Pointer.new("I", 2)
    ip[0] = 0
    ip[1] = ordered_contacts.index(contact)
    table_view.deleteRowsAtIndexPaths([index_path], withRowAnimation: UITableViewRowAnimationLeft)
    table_view.insertRowsAtIndexPaths([NSIndexPath.indexPathWithIndexes(ip, length: 2)], withRowAnimation: UITableViewRowAnimationLeft)
    table_view.endUpdates
  end

  def ordered_contacts
    contacts = []
    contacts += selected_contacts.sort{|a,b| a.first_name <=> b.first_name}
    contacts += unselected_contacts.sort{|a,b| a.first_name <=> b.first_name}
    contacts
  end

  def selected_contacts
    @contacts.select{|x| x.state == :selected }
  end

  def unselected_contacts
    @contacts.select{|x| x.state == :unselected }
  end

  def mock
    contacts = []
    contact = Contact.new("Imran", "Khoja", [{ value: "1 (617) 899-3929" }])
    contact.select
    contacts << contact
    contact = Contact.new("Emily", "Little", [{ value: "555-555-5555" }])
    contact.select
    contacts << contact
    contact = Contact.new("Ben", "Miller", [{ value: "1 (617) 230-2397" }])
    contact.select
    contacts << contact
    contacts << Contact.new("John", "Doe", [{ value: "555-555-5555" }])
    contacts << Contact.new("Abigale", "Doe", [{ value: "555-555-5555" }])
    contacts << Contact.new("Bob", "Doe", [{ value: "555-555-5555" }])
    contacts << Contact.new("Cole", "Doe", [{ value: "555-555-5555" }])
    contacts
  end
end
