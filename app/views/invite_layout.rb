class InviteLayout < MK::Layout
  def layout
    @label00 = add UILabel, :label00 do
      background_color UIColor.whiteColor
      text "Emily wants to go on a run with you!"
      sizeToFit
      frame [[0,64],['100%',45]]
      text_alignment UITextAlignmentCenter
    end

    @label01 = add UILabel, :label01 do
      background_color UIColor.whiteColor
      # text ""
      sizeToFit
      text_alignment UITextAlignmentCenter
      frame [[0,109],['33%',130]]
    end

    @label02 = add UILabel, :label02 do
      background_color UIColor.whiteColor
      # text ""
      sizeToFit
      text_alignment UITextAlignmentCenter
      frame [['33%',109],['33%',130]]
    end

    @label03 = add UILabel, :label03 do
      background_color UIColor.whiteColor
      # text ""
      sizeToFit
      text_alignment UITextAlignmentCenter
      frame [['66%',109],['34%',130]]
    end

    @label04 = add UILabel, :label04 do
      background_color UIColor.colorWithRed(0.118, green:0.541, blue:0.545, alpha:1.0)
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
      background_color UIColor.colorWithRed(0.118, green:0.541, blue:0.545, alpha:1.0)
      title "Swipe to accept >"
      sizeToFit
      frame [[0,523],['100%',45]]
    end

    @label_time = add UILabel, :label_time do
      background_color UIColor.whiteColor
      text "10:54"
      frame [[0,245],['100%',40]]
    end
    @label_time.tap do |l|
      l.textAlignment = UIControlContentHorizontalAlignmentLeft
      l.font = UIFont.fontWithName("Helvetica-Bold", size: 16)
    end

    @image_calendar = UIImageView.alloc.initWithImage(UIImage.imageNamed("calendar4.png"))
    addSubview(@image_calendar)
    @image_calendar.center = CGPointMake(80, 130)

    @label_calendar = add UILabel, :label_calendar do
      frame [[80, -100],['100%','100%']]
      text "5:00 PM"
      text_color UIColor.blackColor
      text_alignment UITextAlignmentCenter
    end
    @label_calendar.center = CGPointMake(80, 160)

    @image_runner = UIImageView.alloc.initWithImage(UIImage.imageNamed("running30.png"))
    addSubview(@image_runner)
    @image_runner.center = CGPointMake(160, 130)

    @label_runner = add UILabel, :label_runner do
      frame [[160, -100],['100%','100%']]
      text "5.5 mi"
      text_color UIColor.blackColor
      text_alignment UITextAlignmentCenter
    end
    @label_runner.center = CGPointMake(160, 160)

    @image_timer = UIImageView.alloc.initWithImage(UIImage.imageNamed("chronograph1.png"))
    addSubview(@image_timer)
    @image_timer.center = CGPointMake(240, 130)

    @label_timer = add UILabel, :label_timer do
      frame [[240, -100],['100%','100%']]
      text "9:00 min/mi"
      text_alignment UITextAlignmentCenter
    end
    @label_timer.center = CGPointMake(240, 160)

    background_color UIColor.grayColor
  end
end
