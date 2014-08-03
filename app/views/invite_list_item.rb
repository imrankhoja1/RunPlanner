class InviteListItem < UITableViewCell
  def initWithStyle(style, reuseIdentifier: reuse_id)
    super(style, reuseIdentifier: reuse_id)
    self.backgroundColor = Constants::AquaBlue

    @label = UILabel.alloc.initWithFrame(CGRectMake(50, 0, 320 - 50, 60))
    @label.color = UIColor.whiteColor
    @label.font = UIFont.fontWithName("Helvetica", size: 14)
    addSubview(@label)

    image_start_time = InviteLayout::make_image("calendar4.png", 70, 80)
    addSubview(image_start_time)

    @label_start_time = InviteLayout::make_label(60, 100)
    addSubview(@label_start_time)

    image_distance = InviteLayout::make_image("running30.png", 160, 80)
    addSubview(image_distance)

    @label_distance = InviteLayout::make_label(150, 100)
    addSubview(@label_distance)

    image_pace = InviteLayout::make_image("chronograph1.png", 250, 80)
    addSubview(image_pace)

    @label_pace = InviteLayout::make_label(240, 100)
    addSubview(@label_pace)
  end

  def set_invitation(invitation)
    @label.text = invitation.sender.first_name + " wants to go on a run with you!"
    @label_start_time.text = invitation.start_time
    @label_distance.text = invitation.distance
    @label_pace.text = invitation.pace
  end
end
