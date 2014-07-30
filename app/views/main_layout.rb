class MainLayout < MK::Layout

  def reflect_state(state, mode)
    if state == :default
    elsif state == :date_clicked
      @starts_picker.show
      @distance_picker.hide
      @pace_picker.hide
    elsif state == :distance_clicked
      @starts_picker.hide
      @distance_picker.show
      @pace_picker.hide
    elsif state == :pace_clicked
      @starts_picker.hide
      @distance_picker.hide
      @pace_picker.show
    end

    if mode == :runners
      @button_runners.backgroundColor = UIColor.grayColor
      @button_meeting.backgroundColor = UIColor.whiteColor
      @map.hide
      @label_contact.show
      @text_field_contact.show
      @table_invites.show
      @invite_cont.show
    elsif mode == :meeting
      @button_runners.backgroundColor = UIColor.whiteColor
      @button_meeting.backgroundColor = UIColor.grayColor
      @label_contact.hide
      @text_field_contact.hide
      @table_invites.hide
      @map.show
      @invite_cont.hide
    end
  end

  def top(element, state=:default)
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
        map:                   64 + 30 + 30 + 30 + 24,
        text_field_contact:    64 + 30 + 30 + 30 + 24,
        table_invites:         64 + 30 + 30 + 30 + 24 + 28,
        invite_cont:           64 + 30 + 30 + 30 + 24 + 270,
        invite:                64 + 30 + 30 + 30 + 24 + 280
      },
      date_clicked: {
        button_distance:       64 + 30 + px,
        button_distance_value: 64 + 30 + px,
        button_pace:           64 + 30 + 30 + px,
        button_pace_value:     64 + 30 + 30 + px,
        button_runners:        64 + 30 + 30 + 30 + px,
        button_meeting:        64 + 30 + 30 + 30 + px,
        map:                   64 + 30 + 30 + 30 + 24 + px,
        text_field_contact:    64 + 30 + 30 + 30 + 24 + px,
        table_invites:         64 + 30 + 30 + 30 + 24 + 28 + px
      },
      distance_clicked: {
        button_pace:        64 + 30 + 30 + px,
        button_pace_value:  64 + 30 + 30 + px,
        button_runners:     64 + 30 + 30 + 30 + px,
        button_meeting:     64 + 30 + 30 + 30 + px,
        map:                64 + 30 + 30 + 30 + 24 + px,
        text_field_contact: 64 + 30 + 30 + 30 + 24 + px,
        table_invites:      64 + 30 + 30 + 30 + 24 + 28 + px
      },
      pace_clicked: {
        button_runners:     64 + 30 + 30 + 30 + px,
        button_meeting:     64 + 30 + 30 + 30 + px,
        map:                64 + 30 + 30 + 30 + 24 + px,
        text_field_contact: 64 + 30 + 30 + 30 + 24 + px,
        table_invites:      64 + 30 + 30 + 30 + 24 + 28 + px
      }
    }

    tops[state][element] || tops[:default][element]
  end

  def height(element, state=:default)
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
    heights[state][element]
  end

  def pickers
    @starts_picker = add UIDatePicker, :starts_picker do
      background_color UIColor.whiteColor
      frame [[0,64 + 30],['100%','100%']]
    end

    @distance_picker = add UIPickerView, :distance_picker do
      background_color UIColor.whiteColor
      frame [[0,64 + 30 + 30],['100%','100%']]
    end
    @distance_picker.tap do |p|
      p.selectRow(9, inComponent: 0, animated: false)
    end

    @pace_picker = add UIPickerView, :pace_picker do
      background_color UIColor.whiteColor
      frame [[0,64 + 30 + 30 + 30],['100%','100%']]
    end
    @pace_picker.tap do |p|
      p.selectRow(16, inComponent: 0, animated: false)
    end
  end

  def start_time_selection
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
      b
    end
    @button_starts_date = add UIButton, :button_starts_date do
      background_color UIColor.whiteColor
      title "Today"
      title_color UIColor.blackColor
      sizeToFit
      frame [['33%',top(:button_starts_date)],['33%',30]]
    end
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
  end

  def distance_selection
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
    end
    @button_distance_value = add UIButton, :button_distance_value do
      background_color UIColor.whiteColor
      title "5.0 mi"
      title_color UIColor.blackColor
      sizeToFit
      frame [['50%',top(:button_distance_value)],['50%',30]]
    end
    @button_distance_value.tap do |b|
      b.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight
      b.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 6)
    end
  end

  def pace_selection
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
    @button_pace_value = add UIButton, :button_pace_value do
      sizeToFit
      frame [['50%',top(:button_pace_value)],['50%',30]]
    end
    @button_pace_value.tap do |b|
      b.setTitle("9:00 min/mi", forState:UIControlStateNormal)
      b.setTitleColor(UIColor.blackColor, forState: UIControlStateNormal)
      b.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight
      b.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 6)
      b.backgroundColor = UIColor.whiteColor
    end
  end

  def runners_meeting
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

    @button_meeting = add UIButton, :button_meeting do
      background_color UIColor.grayColor
      title "Meeting Point"
      title_color UIColor.blackColor
      sizeToFit
      frame [['50%',top(:button_meeting)],['50%',24]]
    end
    @button_meeting.tap do |b|
      b.titleLabel.font = UIFont.fontWithName("Helvetica", size: 14)
    end
  end

  def map
    @map = add MapKit::MapView, :map do
      sizeToFit
      frame [[0,top(:map)],['100%',370]]
    end
  end

  def layout
    pickers
    start_time_selection
    distance_selection
    pace_selection
    runners_meeting
    map

    @label_contact = add UIButton, :label_contact do
      sizeToFit
      frame [[0,top(:text_field_contact)],['15%',28]]
      title "To:"
      title_color UIColor.blackColor
    end
    @label_contact.tap do |l|
      l.titleLabel.font = UIFont.fontWithName("Helvetica-Bold", size: 16)
      l.contentEdgeInsets = UIEdgeInsetsMake(0, 6, 0, 0)
      l.backgroundColor = UIColor.whiteColor
    end

    @text_field_contact = add UITextField, :text_field_contact do
      frame [['15%',top(:text_field_contact)],['85%',28]]
    end
    @text_field_contact.tap do |v|
      v.textColor = UIColor.blackColor
      v.backgroundColor = UIColor.whiteColor
    end

    @table_invites = add UITableView, :table_invites do
      frame [[0,top(:table_invites)],['100%', '100%']]
    end

    @invite_cont = add UILabel, :invite_cont do
      background_color UIColor.whiteColor
      sizeToFit
      frame [[0,top(:invite_cont)],['100%',70]]
    end

    @invite = add UIButton, :invite do
      background_color UIColor.colorWithRed(0.118, green:0.541, blue:0.545, alpha:1.0)
      title "Send Run Invite"
      title_color UIColor.whiteColor
      sizeToFit
      frame [['5%',top(:invite)],['90%',50]]
    end

    background_color UIColor.whiteColor
  end

  def slide_vert(view, new_top)
    center = view.center
    center.y = new_top + (view.frame.size.height / 2)
    view.center = center
  end

  def slide_elements(state)
    UIView.animateWithDuration(0.35, delay: 0, options: UIViewAnimationOptionCurveEaseInOut, animations: lambda {
      slide_vert(@button_distance, top(:button_distance, state))
      slide_vert(@button_distance_value, top(:button_distance_value, state))
      slide_vert(@button_pace, top(:button_pace, state))
      slide_vert(@button_pace_value, top(:button_pace_value, state))
      slide_vert(@button_runners, top(:button_runners, state))
      slide_vert(@button_meeting, top(:button_meeting, state))
      slide_vert(@map, top(:map, state))
      slide_vert(@label_contact, top(:text_field_contact, state))
      slide_vert(@text_field_contact, top(:text_field_contact, state))
      slide_vert(@table_invites, top(:table_invites, state))
    }, completion: lambda { |x|
    })
  end

  def to_front(element_id)
    get(element_id).show
    view.bringSubviewToFront(get(element_id))
  end

  def hide_subviews
    view.subviews.each{|x| x.hide}
  end
end
