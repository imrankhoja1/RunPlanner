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
  end
end
