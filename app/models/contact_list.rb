class ContactList
  attr_accessor :contacts

  def initialize
    address_book = AddressBook::AddrBook.new
    @contacts = address_book.people.select{ |x|
      x.phones.size != 0 && x.first_name != nil && x.last_name != nil
    }.map{ |x|
      Contact.new(x.first_name, x.last_name, x.phones)
    }
    @contacts = Contact.mock_list if @contacts.empty?
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
    selected_contacts.sort{|a,b| a.first_name <=> b.first_name} +
    unselected_contacts.sort{|a,b| a.first_name <=> b.first_name}
  end

  def selected_contacts
    @contacts.select{|x| x.state == :selected }
  end

  def unselected_contacts
    @contacts.select{|x| x.state == :unselected }
  end
end
