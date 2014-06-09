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
    add UILabel, :label7
    add UILabel, :label1
    add UILabel, :label2
    add UILabel, :label8
    add UILabel, :label3
    add UILabel, :label4
    add UILabel, :label9
    add UILabel, :label20
    add UILabel, :label10
    add UILabel, :label11
    add UILabel, :label12
    add UILabel, :label13
    add UILabel, :label100
    add UILabel, :label200
    # add UIDatePicker, :datepicker

    # @button = add UIButton, :button
    # @button.on(:touch) {
    #   UIView.animateWithDuration(0.5, animations: lambda {
    #     frame = @label.frame
    #     frame.size.height = @label.frame.size.height + 50
    #     @label.frame = frame
    #   })
    # }

    background_color UIColor.grayColor
  end

  def datepicker_style
  end

  def label100_style
    size ['100%', '0% + 238']
    center ['50%', '0% + 388']
    background_color UIColor.whiteColor
  end

  def label200_style
    text = 'Send Invite'
    font UIFont.fontWithName('Comic Sans', size: 24)
    size ['80%', '0% + 50']
    center ['50%', '0% + 537']
    text_alignment UITextAlignmentCenter
    color UIColor.blackColor
    background_color UIColor.greenColor
  end

  def label_style
    text 'Starts'
    font UIFont.fontWithName('Comic Sans', size: 24)
    size ['50%', '0% + 40']
    center ['25%', '0% + 84']
    text_alignment UITextAlignmentLeft
    background_color UIColor.whiteColor
  end

  def label7_style
    text '3:00 PM'
    font UIFont.fontWithName('Comic Sans', size: 24)
    size ['50%', '0% + 40']
    center ['75%', '0% + 84']
    text_alignment UITextAlignmentRight
    background_color UIColor.whiteColor
  end

  def label1_style
    size ['100%', '0% + 1']
    center ['50%', '0% + 124']
    background_color UIColor.blackColor
    color UIColor.blackColor
  end

  def label2_style
    text 'Distance'
    font UIFont.fontWithName('Comic Sans', size: 24)
    size ['50%', '0% + 40']
    center ['25%', '0% + 125']
    text_alignment UITextAlignmentLeft
    background_color UIColor.whiteColor
  end

  def label8_style
    text '5.5 mi'
    font UIFont.fontWithName('Comic Sans', size: 24)
    size ['50%', '0% + 40']
    center ['75%', '0% + 125']
    text_alignment UITextAlignmentRight
    background_color UIColor.whiteColor
  end

  def label3_style
    size ['100%', '0% + 1']
    center ['50%', '0% + 165']
    background_color UIColor.blackColor
    color UIColor.blackColor
  end

  def label4_style
    text 'Target Pace'
    font UIFont.fontWithName('Comic Sans', size: 24)
    size ['50%', '0% + 40']
    center ['25%', '0% + 166']
    text_alignment UITextAlignmentLeft
    background_color UIColor.whiteColor
  end

  def label9_style
    text '7:45 min/mi'
    font UIFont.fontWithName('Comic Sans', size: 24)
    size ['50%', '0% + 40']
    center ['75%', '0% + 166']
    text_alignment UITextAlignmentRight
    background_color UIColor.whiteColor
  end

  def label20_style
    size ['100%', '0% + 1']
    center ['50%', '0% + 206']
    background_color UIColor.blackColor
    color UIColor.blackColor
  end

  def label10_style
    text 'Runners'
    font UIFont.fontWithName('Comic Sans', size: 24)
    size ['50%', '0% + 40']
    center ['25%', '0% + 207']
    text_alignment UITextAlignmentCenter
    background_color UIColor.whiteColor
  end

  def label11_style
    text 'Meeting Point'
    font UIFont.fontWithName('Comic Sans', size: 24)
    size ['50%', '0% + 40']
    center ['75%', '0% + 207']
    text_alignment UITextAlignmentCenter
    color UIColor.whiteColor
    background_color UIColor.blackColor
  end

  def label12_style
    size ['100%', '0% + 1']
    center ['50%', '0% + 247']
    background_color UIColor.blackColor
    color UIColor.blackColor
  end

  def label13_style
    text 'Drop a Pin'
    font UIFont.fontWithName('Comic Sans', size: 24)
    size ['100%', '0% + 40']
    center ['50%', '0% + 248']
    text_alignment UITextAlignmentCenter
    background_color UIColor.whiteColor
  end

end
