class MkController < UIViewController
  def loadView
    @layout = SimpleLayout.new
    self.view = @layout.view
    self.title = "Plan Your Run"
  end

end

class SimpleLayout < MK::Layout

  def top(element)
    px = 216

    tops = {
      default: {
        button00: 64,
        button01: 64,
        button02: 64,
        button10: 64 + 30,
        button11: 64 + 30,
        button2:  64 + 30 + 30,
        button3:  64 + 30 + 30 + 30,
        button4:  64 + 30 + 30 + 30,
        button5:  64 + 30 + 30 + 30 + 24 + 1
      },
      date_clicked: {
        button10: 64 + 30 + px,
        button11: 64 + 30 + px,
        button2:  64 + 30 + 30 + px,
        button3:  64 + 30 + 30 + 30 + px,
        button4:  64 + 30 + 30 + 30 + px,
        button5:  64 + 30 + 30 + 30 + 24 + px
      },
      distance_clicked: {
        button2:  64 + 30 + 30 + px,
        button3:  64 + 30 + 30 + 30 + px,
        button4:  64 + 30 + 30 + 30 + px,
        button5:  64 + 30 + 30 + 30 + 24 + px
      },
      pace_clicked: {
        button3:  64 + 30 + 30 + 1 + 30 + px,
        button4:  64 + 30 + 30 + 1 + 30 + px,
        button5:  64 + 30 + 30 + 1 + 30 + 24 + px
      }
    }

    tops[@state][element] || tops[:default][element]
  end

  # this is a special attr method that calls `layout` if the view hasn't been
  # created yet. So you can call `layout.button` before `layout.view` and you
  # won't get nil, and layout.view will be built.
  view :button

  def toggle_state(new_state)
    @state = @state == new_state ? :default : new_state
  end

  def slide_vert(view, new_top)
    center = view.center
    center.y = new_top + (view.frame.size.height / 2)
    view.center = center
  end

  def slide_elements(element_clicked)
    #@map.hide if @state == :default
    UIView.animateWithDuration(0.35, delay: 0, options: UIViewAnimationOptionCurveEaseInOut, animations: lambda {
      slide_vert(@button10, top(:button10))
      slide_vert(@button10, top(:button10))
      slide_vert(@button11, top(:button11))
      slide_vert(@button2, top(:button2))
      slide_vert(@button3, top(:button3))
      slide_vert(@button4, top(:button4))
      slide_vert(@button5, top(:button5))
    }, completion: lambda { |x|
      #@map.show if @state == :default
    })
  end

  def layout
    @datepicker = add UIDatePicker, :datepicker do
      background_color UIColor.whiteColor
      frame [[0,64 + 30],['100%','100%']]
    end

    @state = :default

    @button00 = add UIButton, :button00 do
      background_color UIColor.whiteColor
      title "Starts"
      title_color UIColor.blackColor
      sizeToFit
      frame [[0,top(:button00)],['33%',30]]
    end
    @button00.on(:touch) {
      puts "button00"
      toggle_state(:date_clicked)
      slide_elements(:button00)
    }

    @button01 = add UIButton, :button01 do
      background_color UIColor.whiteColor
      title "Today"
      title_color UIColor.blackColor
      sizeToFit
      frame [['33%',top(:button01)],['33%',30]]
    end
    @button01.on(:touch) {
      puts "button01"
      toggle_state(:date_clicked)
      slide_elements(:button01)
    }

    @button02 = add UIButton, :button02 do
      background_color UIColor.whiteColor
      title "3:00 PM"
      title_color UIColor.blackColor
      sizeToFit
      frame [['66%',top(:button02)],['34%',30]]
    end
    @button02.on(:touch) {
      puts "button02"
      toggle_state(:date_clicked)
      slide_elements(:button02)
    }


    @button10 = add UIButton, :button10 do
      background_color UIColor.whiteColor
      title "Distance"
      title_color UIColor.blackColor
      sizeToFit
      frame [[0,top(:button10)],['50%',30]]
    end
    @button10.on(:touch) {
      puts "button10"
      toggle_state(:distance_clicked)
      slide_elements(:button10)
    }


    @button11 = add UIButton, :button11 do
      background_color UIColor.whiteColor
      title "5.5 mi"
      title_color UIColor.blackColor
      sizeToFit
      #text_alignment UITextAlignmentRight
      frame [['50%',top(:button11)],['50%',30]]
    end
    @button11.on(:touch) {
      puts "button11"
      toggle_state(:distance_clicked)
      slide_elements(:button11)
    }


    @button2 = add UIButton, :button2 do
      background_color UIColor.whiteColor
      title "Target Pace"
      title_color UIColor.blackColor
      sizeToFit
      frame [[0,top(:button2)],['100%',30]]
    end
    @button2.on(:touch) {
      puts "button2"
      toggle_state(:pace_clicked)
      slide_elements(:button2)
    }


    @button3 = add UIButton, :button3 do
      background_color UIColor.whiteColor
      title "Runners"
      title_color UIColor.blackColor
      #text_alignment UITextAlignmentCenter
      sizeToFit
      frame [[0,top(:button3)],['50%',24]]
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
      frame [['50%',top(:button4)],['50%',24]]
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
      frame [[0,top(:button5)],['100%',50]]
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
@map.hide

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
