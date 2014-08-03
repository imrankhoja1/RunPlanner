class InviteListLayout < MK::Layout

  def layout
    @label00 = add UILabel, :label00 do
      background_color UIColor.whiteColor
      text "Your Invites"
      sizeToFit
      frame [[0,64],['100%',45]]
      text_alignment UITextAlignmentCenter
    end

    @table_invites = add UITableView, :table_invites do
      frame [[0,64 + 45],['100%', '100%']]
    end
  end
end
