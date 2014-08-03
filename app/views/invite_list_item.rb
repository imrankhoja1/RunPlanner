class InviteListItem < UITableViewCell
  def initWithStyle(style, reuseIdentifier: reuse_id)
    super(style, reuseIdentifier: reuse_id)
    self.backgroundColor = Constants::AquaBlue

    @label = UILabel.alloc.initWithFrame(CGRectMake(50, 0, 320 - 50, 60))
    @label.color = UIColor.whiteColor
    @label.font = UIFont.fontWithName("Helvetica", size: 14)
    addSubview(@label)

    image_start_time = make_image("calendar4.png", 70, 80)
    addSubview(image_start_time)

    @label_start_time = make_label(60, 100)
    addSubview(@label_start_time)

    image_distance = make_image("running30.png", 160, 80)
    addSubview(image_distance)

    @label_distance = make_label(150, 100)
    addSubview(@label_distance)

    image_pace = make_image("chronograph1.png", 250, 80)
    addSubview(image_pace)

    @label_pace = make_label(240, 100)
    addSubview(@label_pace)
  end

  def make_image(image_name, x, y)
    image = UIImageView.alloc.initWithImage(UIImage.imageNamed(image_name))
    image.center = CGPointMake(x, y)
    image
  end

  def make_label(x, y)
    label = UILabel.alloc.initWithFrame(CGRectMake(x, y, 100, 20))
    label.font = UIFont.fontWithName("Helvetica", size: 14)
    label.color = UIColor.whiteColor
    label
  end

  def set_invitation(invitation)
    @label.text = invitation.sender.first_name + " wants to go on a run with you!"
    @label_start_time.text = invitation.start_time
    @label_distance.text = invitation.distance
    @label_pace.text = invitation.pace
  end
end
