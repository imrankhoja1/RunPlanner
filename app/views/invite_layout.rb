class InviteLayout < MK::Layout
  def layout
    @label_inviter = add UILabel, :label_inviter do
      background_color UIColor.whiteColor
      text "Emily wants to go on a run with you!"
      sizeToFit
      frame [[0,64],['100%',45]]
      text_alignment UITextAlignmentCenter
    end

    @label_hurry = add UILabel, :label_hurry do
      background_color Constants::AquaBlue
      color UIColor.whiteColor
      text "Hurry! This invite expires in:"
      sizeToFit
      text_alignment UITextAlignmentCenter
      frame [[0,200],['100%',45]]
    end

    @map = add MapKit::MapView, :map do
      frame [[0,284],['100%',239]]
    end

    @button_accept = add UIButton, :button_accept do
      background_color Constants::AquaBlue
      title "Hold to accept"
      sizeToFit
      frame [[0,523],['100%',45]]
    end

    @label_countdown = add UILabel, :label_countdown do
      background_color UIColor.whiteColor
      text "10:54"
      frame [[0,245],['100%',40]]
    end
    @label_countdown.tap do |l|
      l.textAlignment = UIControlContentHorizontalAlignmentLeft
      l.font = UIFont.fontWithName("Helvetica-Bold", size: 16)
    end

    @image_start_time = InviteLayout::make_image("calendar4.png", 80, 130)
    addSubview(@image_start_time)

    @label_start_time = add UILabel, :label_start_time do
      frame [[80, -100],['100%','100%']]
      text "5:00 PM"
      text_color UIColor.blackColor
      text_alignment UITextAlignmentCenter
    end
    @label_start_time.center = CGPointMake(80, 160)

    @image_distance = InviteLayout::make_image("running30.png", 160, 130)
    addSubview(@image_distance)

    @label_distance = add UILabel, :label_distance do
      frame [[160, -100],['100%','100%']]
      text "5.5 mi"
      text_color UIColor.blackColor
      text_alignment UITextAlignmentCenter
    end
    @label_distance.center = CGPointMake(160, 160)

    @image_pace = InviteLayout::make_image("chronograph1.png", 240, 130)
    addSubview(@image_pace)

    @label_pace = add UILabel, :label_pace do
      frame [[240, -100],['100%','100%']]
      text "9:00 min/mi"
      text_alignment UITextAlignmentCenter
    end
    @label_pace.center = CGPointMake(240, 160)

    background_color UIColor.whiteColor
  end

  def self.make_image(image_name, x, y)
    image = UIImageView.alloc.initWithImage(UIImage.imageNamed(image_name))
    image.center = CGPointMake(x, y)
    image
  end

  def self.make_label(x, y)
    label = UILabel.alloc.initWithFrame(CGRectMake(x, y, 100, 20))
    label.font = UIFont.fontWithName("Helvetica", size: 14)
    label.color = UIColor.whiteColor
    label
  end
end
