class InviteListController < UIViewController
  def loadView
    @layout = InviteListLayout.new
    self.view = @layout.view
    self.title = Constants::AppTitle

    @invitations = Invitation.mock_list

    init_elements
  end

  def init_elements
    @layout.get(:table_invites).delegate = self
    @layout.get(:table_invites).dataSource = self
  end

  def tableView(table_view, numberOfRowsInSection:section)
    @invitations.size
  end

  def tableView(table_view, heightForRowAtIndexPath: index_path)
    144
  end

  def tableView(table_view, didSelectRowAtIndexPath: index_path)
    row = index_path.row
    invite_controller = navigationController.delegate.invite_controller
    navigationController.pushViewController(invite_controller, animated: true)
  end

  def tableView(table_view, cellForRowAtIndexPath: index_path)
    row = index_path.row
    invitation = @invitations[row]
    reuse_id = nil
    cell = table_view.dequeueReusableCellWithIdentifier(reuse_id) || begin
      puts "creating list item"
      InviteListItem.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier: reuse_id)
    end
    cell.set_invitation(invitation)
    cell
  end
end
