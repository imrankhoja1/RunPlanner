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
        button_starts: 64,
        button_starts_date: 64,
        button_starts_time: 64,
        button10: 64 + 30,
        button11: 64 + 30,
        button2:  64 + 30 + 30,
        button3:  64 + 30 + 30 + 30,
        button4:  64 + 30 + 30 + 30,
        button5:  64 + 30 + 30 + 30 + 24,
        map:      64 + 30 + 30 + 30 + 24 + 50
      },
      date_clicked: {
        button10: 64 + 30 + px,
        button11: 64 + 30 + px,
        button2:  64 + 30 + 30 + px,
        button3:  64 + 30 + 30 + 30 + px,
        button4:  64 + 30 + 30 + 30 + px,
        button5:  64 + 30 + 30 + 30 + 24 + px,
        map:      64 + 30 + 30 + 30 + 24 + 50 + px
      },
      distance_clicked: {
        button2:  64 + 30 + 30 + px,
        button3:  64 + 30 + 30 + 30 + px,
        button4:  64 + 30 + 30 + 30 + px,
        button5:  64 + 30 + 30 + 30 + 24 + px,
        map:      64 + 30 + 30 + 30 + 24 + 50 + px
      },
      pace_clicked: {
        button3:  64 + 30 + 30 + 30 + px,
        button4:  64 + 30 + 30 + 30 + px,
        button5:  64 + 30 + 30 + 30 + 24 + px,
        map:      64 + 30 + 30 + 30 + 24 + 50 + px
      }
    }

    tops[@state][element] || tops[:default][element]
  end

  def height(element)
    px = 216

    heights = {
      default: {
        map: px
      },
      date_clicked: {
        map: 0
      },
      distance_clicked: {
        datepicker: 216
      },
      pace_clicked: {
        datepicker: 216
      }
    }
    heights[@state][element] || heights[:default][element]
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

  def expand_vert(view, new_height)
    frame = view.frame
    frame.size.height = new_height
    view.frame = frame
  end

  def show_hide_pickers
    return if @state == :default
    @state == :date_clicked ? @datepicker.show : @datepicker.hide
    @state == :distance_clicked ? @distance_picker.show : @distance_picker.hide
    @state == :pace_clicked ? @pace_picker.show : @pace_picker.hide
  end

  def slide_elements
    show_hide_pickers

    UIView.animateWithDuration(0.35, delay: 0, options: UIViewAnimationOptionCurveEaseInOut, animations: lambda {
      slide_vert(@button10, top(:button10))
      slide_vert(@button10, top(:button10))
      slide_vert(@button11, top(:button11))
      slide_vert(@button2, top(:button2))
      slide_vert(@button3, top(:button3))
      slide_vert(@button4, top(:button4))
      slide_vert(@button5, top(:button5))
      slide_vert(@map, top(:map))
    }, completion: lambda { |x|
    })
  end

  def update_date
    # Ruby Motion automatically converts NSDate objects into Ruby Time objects
    date = @datepicker.date.strftime("%a %b %e")
    date = "Today" if date == Time.now.strftime("%a %b %e")
    time = @datepicker.date.strftime("%l:%M %p")
    @button_starts_date.setTitle(date, forState: UIControlStateNormal)
    @button_starts_time.setTitle(time, forState: UIControlStateNormal)
  end

  def layout
    @state = :default

    @datepicker = add UIDatePicker, :datepicker do
      background_color UIColor.whiteColor
      frame [[0,64 + 30],['100%','100%']]
    end
    @datepicker.addTarget(self, action: 'update_date', forControlEvents: UIControlEventValueChanged)
    @datepicker.hide

    @distance_picker = add UIPickerView, :distance_picker do
      background_color UIColor.whiteColor
      frame [[0,64 + 30 + 30],['100%','100%']]
    end
    @distance_picker.delegate = @distance_picker.dataSource = self
    @distance_picker.hide

    @pace_picker = add UIPickerView, :distance_picker do
      background_color UIColor.whiteColor
      frame [[0,64 + 30 + 30 + 30],['100%','100%']]
    end
    @pace_picker.delegate = @pace_picker.dataSource = self
    @pace_picker.hide

    @button_starts = add UIButton, :button_starts do
      sizeToFit
      frame [[0,top(:button_starts)],['33%',30]]
    end
    @button_starts.tap do |b|
      b.setTitle("Starts", forState:UIControlStateNormal)
      b.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft
      b.contentEdgeInsets = UIEdgeInsetsMake(0, 6, 0, 0)
      b.titleLabel.font = UIFont.fontWithName("Helvetica-Bold", size: 16)
      b.titleLabel.color = UIColor.blackColor
      b.titleLabel.textAlignment = UITextAlignmentLeft
      b.on(:touch) {
        puts "button_starts"
        toggle_state(:date_clicked)
        @datepicker.show
        slide_elements
      }
      b
    end

    @button_starts_date = add UIButton, :button_starts_date do
      background_color UIColor.whiteColor
      title "Today"
      title_color UIColor.blackColor
      sizeToFit
      frame [['33%',top(:button_starts_date)],['33%',30]]
    end
    @button_starts_date.on(:touch) {
      puts "button_starts_date"
      toggle_state(:date_clicked)
      @datepicker.show
      slide_elements
    }

    @button_starts_time = add UIButton, :button_starts_time do
      background_color UIColor.whiteColor
      title (Time.now + 30*60).strftime("%l:%M %p")
      title_color UIColor.blackColor
      sizeToFit
      frame [['66%',top(:button_starts_time)],['34%',30]]
    end
    @button_starts_time.on(:touch) {
      puts "button_starts_time"
      toggle_state(:date_clicked)
      @datepicker.show
      slide_elements
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
      slide_elements
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
      slide_elements
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
      slide_elements
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
      @state = :default
      slide_elements
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
      @state = :default
      slide_elements
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
      @state = :default
      slide_elements
    }


    @map = add MKMapView, :map do
      sizeToFit
      frame [[0,top(:map)],['100%','100%']]
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
      @state = :default
      slide_elements
    }

    background_color UIColor.whiteColor
  end


  # picker view methods (ran into memory issues when trying to do this in a delegate class)
  def numberOfComponentsInPickerView(picker_view)
    1
  end

  def pickerView(picker_view, numberOfRowsInComponent: component)
    10
  end

  def pickerView(picker_view, viewForRow: row, forComponent: component, reusingView: old_view)
    (old_view || DistancePickerView.new).tap do |asdf|
      if picker_view == @distance_picker
        asdf.label.text = "distance"
      elsif picker_view == @pace_picker
        asdf.label.text = "pace"
      end
      asdf
    end
  end

end
