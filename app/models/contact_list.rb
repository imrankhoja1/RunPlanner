class ContactList
  attr_accessor :contacts

  def initialize
    address_book = AddressBook::AddrBook.new
    @contacts = address_book.people.map{|x| x}
    @contacts = MockContacts.mock if @contacts.empty?
    @selected_contacts = []
  end

  def tableView(table_view, numberOfRowsInSection:section)
    @contacts.size
  end

  def tableView(table_view, cellForRowAtIndexPath: index_path)
    row = index_path.row
    reuse_id = "table_id_#{@contacts[row].last_name}"
    NSLog(reuse_id)
    cell = table_view.dequeueReusableCellWithIdentifier(reuse_id) || begin
      cl = UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier: reuse_id)
      cl.accessoryType = UITableViewCellAccessoryCheckmark
      cl
    end
    cell.textLabel.text = "#{@contacts[row].first_name} #{@contacts[row].last_name}"
    cell
  end

  def tableView(table_view, didSelectRowAtIndexPath: index_path)
    cell = table_view.cellForRowAtIndexPath(index_path)

    @contacts.insert(0, @contacts[index_path.row])
    @contacts.delete_at(index_path.row + 1)

    table_view.beginUpdates
    ip = Pointer.new("I", 2)
    ip[0] = 0
    ip[1] = 0
    table_view.insertRowsAtIndexPaths([NSIndexPath.indexPathWithIndexes(ip, length: 2)], withRowAnimation: UITableViewRowAnimationLeft)
    table_view.deleteRowsAtIndexPaths([index_path], withRowAnimation: UITableViewRowAnimationLeft)
    table_view.endUpdates
  end
end
