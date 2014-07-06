class ContactList
  def initialize
    #@address_book = AddressBook::AddrBook.new
  end

  def contacts
    #@address_book.people

    # mock it for now
    [{:first_name => "Imran", :last_name => "Khoja", :phones => [{:value => '+16172302397', :label => 'Mobile'}]},
     {:first_name => "Emily", :last_name => "Little", :phones => [{:value => '+16172302397', :label => 'Mobile'}]}]
  end

  def tableView(table_view, numberOfRowsInSection:section)
    contacts.size
  end

  def tableView(table_view, cellForRowAtIndexPath: index_path)
    row = index_path.row
    reuse_id = "table_id_#{row}"
    cell = table_view.dequeueReusableCellWithIdentifier(reuse_id) || begin
      UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier: reuse_id)
    end
    cell.textLabel.text = "#{contacts[row][:first_name]} #{contacts[row][:last_name]}"
    cell
  end
end
