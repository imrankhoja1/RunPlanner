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
    @label = add UILabel, :label
    add UILabel, :label2
    add UIDatePicker, :datepicker

    @button = add UIButton, :button
    @button.on(:touch) {
      UIView.animateWithDuration(0.5, animations: lambda {
        frame = @label.frame
        frame.size.height = @label.frame.size.height + 50
        @label.frame = frame
      })
    }

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

  def label2_style
    text 'Hi there! Welcome to MotionKit'
    font UIFont.fontWithName('Comic Sans', size: 24)
    sizeToFit

    # note: there are better ways to set the center, see the frame helpers below
    #center [CGRectGetMidX(superview.bounds), CGRectGetMidY(superview.bounds)]
    center ['50%', '50% + 50']
    text_alignment UITextAlignmentCenter
    text_color UIColor.whiteColor

    # if you prefer to use shorthands from another gem, you certainly can!
    #background_color rmq.color.white  # from RMQ
    #background_color :white.uicolor   # from SugarCube
    background_color UIColor.greenColor
  end

  def button_style
puts "button style"
    # this will call 'setTitle(forState:)' via a UIButton helper
    title 'Press it!'
    sizeToFit
    # this shorthand is much better!  More about frame helpers below.
    frame [[0,0],['50%',:scale]]
    center ['50%', '50% + 100']
    background_color UIColor.blueColor
  end

end
