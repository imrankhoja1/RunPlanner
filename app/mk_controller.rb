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
        button_starts:         64,
        button_starts_date:    64,
        button_starts_time:    64,
        button_distance:       64 + 30,
        button_distance_value: 64 + 30,
        button_pace:           64 + 30 + 30,
        button_pace_value:     64 + 30 + 30,
        button_runners:        64 + 30 + 30 + 30,
        button_meeting:        64 + 30 + 30 + 30,
        button_drop:           64 + 30 + 30 + 30 + 24,
        map:                   64 + 30 + 30 + 30 + 24 + 50,
        invite_cont:           64 + 30 + 30 + 30 + 24 + 50 + 270,
        invite:                64 + 30 + 30 + 30 + 24 + 50 + 280
      },
      date_clicked: {
        button_distance:       64 + 30 + px,
        button_distance_value: 64 + 30 + px,
        button_pace:           64 + 30 + 30 + px,
        button_pace_value:     64 + 30 + 30 + px,
        button_runners:        64 + 30 + 30 + 30 + px,
        button_meeting:        64 + 30 + 30 + 30 + px,
        button_drop:           64 + 30 + 30 + 30 + 24 + px,
        map:                   64 + 30 + 30 + 30 + 24 + 50 + px
      },
      distance_clicked: {
        button_pace:       64 + 30 + 30 + px,
        button_pace_value: 64 + 30 + 30 + px,
        button_runners:    64 + 30 + 30 + 30 + px,
        button_meeting:    64 + 30 + 30 + 30 + px,
        button_drop:       64 + 30 + 30 + 30 + 24 + px,
        map:               64 + 30 + 30 + 30 + 24 + 50 + px
      },
      pace_clicked: {
        button_runners: 64 + 30 + 30 + 30 + px,
        button_meeting: 64 + 30 + 30 + 30 + px,
        button_drop:    64 + 30 + 30 + 30 + 24 + px,
        map:            64 + 30 + 30 + 30 + 24 + 50 + px
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
        starts_picker: 216
      },
      pace_clicked: {
        starts_picker: 216
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
    @state == :date_clicked ? @starts_picker.show : @starts_picker.hide
    @state == :distance_clicked ? @distance_picker.show : @distance_picker.hide
    @state == :pace_clicked ? @pace_picker.show : @pace_picker.hide
  end

  def slide_elements
    show_hide_pickers

    UIView.animateWithDuration(0.35, delay: 0, options: UIViewAnimationOptionCurveEaseInOut, animations: lambda {
      slide_vert(@button_distance, top(:button_distance))
      slide_vert(@button_distance, top(:button_distance))
      slide_vert(@button_distance_value, top(:button_distance_value))
      slide_vert(@button_pace, top(:button_pace))
      slide_vert(@button_pace_value, top(:button_pace_value))
      slide_vert(@button_runners, top(:button_runners))
      slide_vert(@button_meeting, top(:button_meeting))
      slide_vert(@button_drop, top(:button_drop))
      slide_vert(@map, top(:map))
    }, completion: lambda { |x|
    })
  end

  def update_date
    # Ruby Motion automatically converts NSDate objects into Ruby Time objects
    date = @starts_picker.date.strftime("%a %b %e")
    date = "Today" if date == Time.now.strftime("%a %b %e")
    time = @starts_picker.date.strftime("%l:%M %p")
    @button_starts_date.setTitle(date, forState: UIControlStateNormal)
    @button_starts_time.setTitle(time, forState: UIControlStateNormal)
  end

  def layout
    @state = :default

    @starts_picker = add UIDatePicker, :starts_picker do
      background_color UIColor.whiteColor
      frame [[0,64 + 30],['100%','100%']]
    end
    @starts_picker.addTarget(self, action: 'update_date', forControlEvents: UIControlEventValueChanged)
    @starts_picker.hide

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
      b.setTitleColor(UIColor.blackColor, forState: UIControlStateNormal)
      b.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft
      b.contentEdgeInsets = UIEdgeInsetsMake(0, 6, 0, 0)
      b.titleLabel.font = UIFont.fontWithName("Helvetica-Bold", size: 16)
      b.on(:touch) {
        puts "button_starts"
        toggle_state(:date_clicked)
        @starts_picker.show
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
      @starts_picker.show
      slide_elements
    }

    @button_starts_time = add UIButton, :button_starts_time do
      background_color UIColor.whiteColor
      title (Time.now + 30*60).strftime("%l:%M %p")
      title_color UIColor.blackColor
      sizeToFit
      frame [['66%',top(:button_starts_time)],['34%',30]]
    end
    @button_starts_time.tap do |b|
      b.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight
      b.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 6)
    end
    @button_starts_time.on(:touch) {
      puts "button_starts_time"
      toggle_state(:date_clicked)
      @starts_picker.show
      slide_elements
    }


    @button_distance = add UIButton, :button_distance do
      sizeToFit
      frame [[0,top(:button_distance)],['50%',30]]
    end
    @button_distance.tap do |b|
      b.setTitle("Distance", forState:UIControlStateNormal)
      b.setTitleColor(UIColor.blackColor, forState: UIControlStateNormal)
      b.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft
      b.contentEdgeInsets = UIEdgeInsetsMake(0, 6, 0, 0)
      b.titleLabel.font = UIFont.fontWithName("Helvetica-Bold", size: 16)
      b.backgroundColor = UIColor.whiteColor

      b.on(:touch) {
        puts "button_distance"
        toggle_state(:distance_clicked)
        slide_elements
      }
    end


    @button_distance_value = add UIButton, :button_distance_value do
      background_color UIColor.whiteColor
      title "5.5 mi"
      title_color UIColor.blackColor
      sizeToFit
      frame [['50%',top(:button_distance_value)],['50%',30]]
    end
    @button_distance_value.tap do |b|
      b.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight
      b.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 6)
    end
    @button_distance_value.on(:touch) {
      puts "button_distance_value"
      toggle_state(:distance_clicked)
      slide_elements
    }


    @button_pace = add UIButton, :button_pace do
      background_color UIColor.whiteColor
      title "Target Pace"
      title_color UIColor.blackColor
      sizeToFit
      frame [[0,top(:button_pace)],['50%',30]]
    end
    @button_pace.tap do |b|
      b.setTitle("Target Pace", forState:UIControlStateNormal)
      b.setTitleColor(UIColor.blackColor, forState: UIControlStateNormal)
      b.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft
      b.contentEdgeInsets = UIEdgeInsetsMake(0, 6, 0, 0)
      b.titleLabel.font = UIFont.fontWithName("Helvetica-Bold", size: 16)
      b.backgroundColor = UIColor.whiteColor
    end
    @button_pace.on(:touch) {
      puts "button_pace"
      toggle_state(:pace_clicked)
      slide_elements
    }

    @button_pace_value = add UIButton, :button_pace_value do
      sizeToFit
      frame [['50%',top(:button_pace_value)],['50%',30]]
    end
    @button_pace_value.tap do |b|
      b.setTitle("7:45 min/mi", forState:UIControlStateNormal)
      b.setTitleColor(UIColor.blackColor, forState: UIControlStateNormal)
      b.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight
      b.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 6)
      b.backgroundColor = UIColor.whiteColor
    end
    @button_pace_value.on(:touch) {
      puts "button_pace_value"
      toggle_state(:pace_clicked)
      slide_elements
    }


    @button_runners = add UIButton, :button_runners do
      background_color UIColor.whiteColor
      title "Runners"
      title_color UIColor.blackColor
      sizeToFit
      frame [[0,top(:button_runners)],['50%',24]]
    end
    @button_runners.tap do |b|
      b.titleLabel.font = UIFont.fontWithName("Helvetica", size: 14)
    end
    @button_runners.on(:touch) {
      puts "button_runners"
      @state = :default
      slide_elements
    }


    @button_meeting = add UIButton, :button_meeting do
      background_color UIColor.grayColor
      title "Meeting Point"
      title_color UIColor.blackColor
      #text_alignment UITextAlignmentCenter
      sizeToFit
      frame [['50%',top(:button_meeting)],['50%',24]]
    end
    @button_meeting.tap do |b|
      b.titleLabel.font = UIFont.fontWithName("Helvetica", size: 14)
    end
    @button_meeting.on(:touch) {
      puts "button_meeting"
      @state = :default
      slide_elements
    }


    @button_drop = add UIButton, :button_drop do
      background_color UIColor.whiteColor
      title "Drop a Pin"
      title_color UIColor.blackColor
      #text_alignment UITextAlignmentCenter
      sizeToFit
      frame [[0,top(:button_drop)],['100%',50]]
    end
    @button_drop.tap do |b|
      b.titleLabel.font = UIFont.fontWithName("Helvetica-Bold", size: 18)
    end
    @button_drop.on(:touch) {
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
      frame [[0,top(:invite_cont)],['100%',70]]
    end

    @invite = add UIButton, :invite do
      background_color UIColor.colorWithRed(0.169, green: 0.561, blue: 0.329, alpha: 1.0)
      title "Send Run Invite"
      title_color UIColor.whiteColor
      sizeToFit
      frame [['5%',top(:invite)],['90%',50]]
    end
    @invite.tap do |b|
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
