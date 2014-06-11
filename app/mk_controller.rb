class MkController < UIViewController
  def loadView
    @layout = SimpleLayout.new
    self.view = @layout.view

    #@button = @layout.get(:button)  # This will be created in our layout (below)

    self.title = "Plan Your Run"
  end

end

class SimpleLayout < MK::Layout
  # this is a special attr method that calls `layout` if the view hasn't been
  # created yet. So you can call `layout.button` before `layout.view` and you
  # won't get nil, and layout.view will be built.
  view :button

  def layout
    #@label = add UILabel, :label
    #add UILabel, :label2
    #add UIDatePicker, :datepicker

    #@button = add UIButton, :button
    #@button.on(:touch) {
    #  UIView.animateWithDuration(0.5, animations: lambda {
    #    frame = @label.frame
    #    frame.size.height = @label.frame.size.height + 50
    #    @label.frame = frame
    #  })
    #}

    @label00 = add UILabel, :label00 do
      background_color UIColor.whiteColor
      text "Starts"
      sizeToFit
      frame [[0,64],['33%',30]]
    end

    @label01 = add UILabel, :label01 do
      background_color UIColor.whiteColor
      text "Today"
      sizeToFit
      text_alignment UITextAlignmentCenter
      frame [['33%',64],['33%',30]]
    end

    @label02 = add UILabel, :label02 do
      background_color UIColor.whiteColor
      text "3:00 PM"
      text_alignment UITextAlignmentRight
      sizeToFit
      frame [['66%',64],['34%',30]]
    end

    @label10 = add UILabel, :label10 do
      background_color UIColor.whiteColor
      text "Distance"
      sizeToFit
      frame [[0,30 + 64 + 1],['50%',30]]
    end

    @label11 = add UILabel, :label11 do
      background_color UIColor.whiteColor
      text "5.5 mi"
      sizeToFit
      text_alignment UITextAlignmentRight
      frame [['50%',30 + 64 + 1],['50%',30]]
    end

    @label2 = add UILabel, :label2 do
      background_color UIColor.whiteColor
      text "Target Pace"
      sizeToFit
      frame [[0,30 + 30 + 64 + 1 + 1],['100%',30]]
    end

    @label3 = add UILabel, :label3 do
      background_color UIColor.whiteColor
      text "Runners"
      text_alignment UITextAlignmentCenter
      sizeToFit
      frame [[0,30 + 30 + 64 + 1 + 1 + 30 + 1],['50%',24]]
    end

    @label4 = add UILabel, :label4 do
      background_color UIColor.grayColor
      text "Meeting Point"
      text_alignment UITextAlignmentCenter
      sizeToFit
      frame [['50%',30 + 30 + 64 + 1 + 1 + 30 + 1],['50%',24]]
    end

    @label5 = add UILabel, :label5 do
      background_color UIColor.whiteColor
      text "Drop a Pin"
      text_alignment UITextAlignmentCenter
      sizeToFit
      frame [[0,30 + 30 + 64 + 1 + 1 + 30 + 1 + 24 + 1],['100%',50]]
    end

    @map = add UILabel, :map do
      background_color UIColor.blueColor
      text "Map!"
      sizeToFit
      frame [[0,30 + 30 + 64 + 1 + 1 + 30 + 1 + 24 + 50 + 1],['100%',264]]
    end

    @invite_cont = add UILabel, :invite_cont do
      background_color UIColor.whiteColor
      sizeToFit
      frame [[0,30 + 30 + 64 + 1 + 1 + 30 + 1 + 24 + 50 + 1 + 264 + 1],['100%',70]]
    end

    @invite = add UILabel, :invite do
      background_color UIColor.greenColor
      text "Send Run Invite"
      text_alignment UITextAlignmentCenter
      sizeToFit
      asdf = 30 + 30 + 64 + 1 + 1 + 30 + 1 + 24 + 50 + 1 + 258 + 1
      frame [['5%',asdf + 10],['90%',50]]
    end

    background_color UIColor.grayColor
  end

  def label_style
    text 'Hi there! Welcome to MotionKit'
    font UIFont.fontWithName('Comic Sans', size: 24)
    sizeToFit

    # note: there are better ways to set the center, see the frame helpers below
    center [CGRectGetMidX(superview.bounds), CGRectGetMidY(superview.bounds)]
    text_alignment UITextAlignmentCenter
    text_color UIColor.whiteColor

    # if you prefer to use shorthands from another gem, you certainly can!
    #background_color rmq.color.white  # from RMQ
    #background_color :white.uicolor   # from SugarCube
    background_color UIColor.greenColor
  end

  def button_style
    # this will call 'setTitle(forState:)' via a UIButton helper
    title 'Press it!'
    sizeToFit
    # this shorthand is much better!  More about frame helpers below.
    frame [[0,0],['50%',:scale]]
    center ['50%', '50% + 100']
    background_color UIColor.blueColor
  end

end
