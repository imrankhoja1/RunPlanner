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

    @button00 = add UIButton, :button00 do
      background_color UIColor.whiteColor
      title "Starts"
      title_color UIColor.blackColor
      sizeToFit
      frame [[0,64],['33%',30]]
    end
    @button00.on(:touch) {
      puts "button00"
    }

    @button01 = add UIButton, :button01 do
      background_color UIColor.whiteColor
      title "Today"
      title_color UIColor.blackColor
      sizeToFit
      frame [['33%',64],['33%',30]]
    end
    @button01.on(:touch) {
      puts "button01"
    }

    @button02 = add UIButton, :button02 do
      background_color UIColor.whiteColor
      title "3:00 PM"
      title_color UIColor.blackColor
      sizeToFit
      frame [['66%',64],['34%',30]]
    end
    @button02.on(:touch) {
      puts "button02"
    }


    @button10 = add UIButton, :button10 do
      background_color UIColor.whiteColor
      title "Distance"
      title_color UIColor.blackColor
      sizeToFit
      frame [[0,30 + 64 + 1],['50%',30]]
    end
    @button10.on(:touch) {
      puts "button10"
    }


    @button11 = add UIButton, :button11 do
      background_color UIColor.whiteColor
      title "5.5 mi"
      title_color UIColor.blackColor
      sizeToFit
      #text_alignment UITextAlignmentRight
      frame [['50%',30 + 64 + 1],['50%',30]]
    end
    @button11.on(:touch) {
      puts "button11"
    }


    @button2 = add UIButton, :button2 do
      background_color UIColor.whiteColor
      title "Target Pace"
      title_color UIColor.blackColor
      sizeToFit
      frame [[0,30 + 30 + 64 + 1 + 1],['100%',30]]
    end
    @button2.on(:touch) {
      puts "button2"
    }


    @button3 = add UIButton, :button3 do
      background_color UIColor.whiteColor
      title "Runners"
      title_color UIColor.blackColor
      #text_alignment UITextAlignmentCenter
      sizeToFit
      frame [[0,30 + 30 + 64 + 1 + 1 + 30 + 1],['50%',24]]
    end
    @button3.on(:touch) {
      puts "button3"
    }


    @button4 = add UIButton, :button4 do
      background_color UIColor.grayColor
      title "Meeting Point"
      title_color UIColor.blackColor
      #text_alignment UITextAlignmentCenter
      sizeToFit
      frame [['50%',30 + 30 + 64 + 1 + 1 + 30 + 1],['50%',24]]
    end
    @button4.on(:touch) {
      puts "button4"
    }


    @button5 = add UIButton, :button5 do
      background_color UIColor.whiteColor
      title "Drop a Pin"
      title_color UIColor.blackColor
      #text_alignment UITextAlignmentCenter
      sizeToFit
      frame [[0,30 + 30 + 64 + 1 + 1 + 30 + 1 + 24 + 1],['100%',50]]
    end
    @button5.on(:touch) {
      puts "button05"
    }


    @map = add UIButton, :map do
      background_color UIColor.blueColor
      title "Map!"
      title_color UIColor.blackColor
      sizeToFit
      frame [[0,30 + 30 + 64 + 1 + 1 + 30 + 1 + 24 + 50 + 1],['100%',264]]
    end

    @invite_cont = add UILabel, :invite_cont do
      background_color UIColor.whiteColor
      sizeToFit
      frame [[0,30 + 30 + 64 + 1 + 1 + 30 + 1 + 24 + 50 + 1 + 264 + 1],['100%',70]]
    end

    @invite = add UIButton, :invite do
      background_color UIColor.greenColor
      title "Send Run Invite"
      title_color UIColor.blackColor
      #text_alignment UITextAlignmentCenter
      sizeToFit
      asdf = 30 + 30 + 64 + 1 + 1 + 30 + 1 + 24 + 50 + 1 + 258 + 1
      frame [['5%',asdf + 10],['90%',50]]
    end
    @invite.on(:touch) {
      puts "invite"
    }


    background_color UIColor.grayColor
  end

  def label_style
    text 'Hi there! Welcome to MotionKit'
    font UIFont.fontWithName('Comic Sans', size: 24)
    sizeToFit

    # note: there are better ways to set the center, see the frame helpers below
    center [CGRectGetMidX(superview.bounds), CGRectGetMidY(superview.bounds)]
    #text_alignment UITextAlignmentCenter
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
