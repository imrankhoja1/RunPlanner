class MainController < UIViewController
  def loadView
    @layout = MainLayout.new

    self.view = @layout.view
    self.title = "Plan Your Run"

    init_buttons
    set_delegates

    @state = :default
    @mode = :runners
    @layout.reflect_state(@state, @mode)
  end

  def init_buttons
    @layout.get(:button_starts).on(:touch) {
      date_clicked
    }
    @layout.get(:button_starts_date).on(:touch) {
      date_clicked
    }
    @layout.get(:button_starts_time).on(:touch) {
      date_clicked
    }

    @layout.get(:button_distance).on(:touch) {
      distance_clicked
    }
    @layout.get(:button_distance_value).on(:touch) {
      distance_clicked
    }

    @layout.get(:button_pace).on(:touch) {
      pace_clicked
    }
    @layout.get(:button_pace_value).on(:touch) {
      pace_clicked
    }
  end

  def set_delegates
    @contact_list = ContactList.new
    @layout.get(:table_invites).dataSource = @contact_list

    @layout.get(:starts_picker).addTarget(self, action: 'update_date', forControlEvents: UIControlEventValueChanged)

    @layout.get(:distance_picker).delegate = self
    @layout.get(:distance_picker).dataSource = self
    @layout.get(:distance_picker).selectRow(9, inComponent: 0, animated: false)

    @layout.get(:pace_picker).delegate = self
    @layout.get(:pace_picker).dataSource = self
    @layout.get(:pace_picker).selectRow(16, inComponent: 0, animated: false)
  end

  def toggle_state(new_state)
    @state = @state == new_state ? :default : new_state
  end

  def date_clicked
    toggle_state(:date_clicked)
    @layout.reflect_state(@state, @mode)
    @layout.slide_elements(@state)
  end

  def distance_clicked
    toggle_state(:distance_clicked)
    @layout.reflect_state(@state, @mode)
    @layout.slide_elements(@state)
  end

  def pace_clicked
    toggle_state(:pace_clicked)
    @layout.reflect_state(@state, @mode)
    @layout.slide_elements(@state)
  end

  def update_date
    # Ruby Motion automatically converts NSDate objects into Ruby Time objects
    date = @layout.get(:starts_picker).date.strftime("%a %b %e")
    date = "Today" if date == Time.now.strftime("%a %b %e")
    time = @layout.get(:starts_picker).date.strftime("%l:%M %p")
    @layout.get(:button_starts_date).setTitle(date, forState: UIControlStateNormal)
    @layout.get(:button_starts_time).setTitle(time, forState: UIControlStateNormal)
  end

  def distance_picker_values
    @distance_picker_values ||= 0.5.step(20, 0.5).to_a.map{|x| "#{x} mi"}
  end

  def pace_picker_values
    @pace_picker_values ||= 5.step(30, 0.25).to_a.map do |x|
      mins = x.to_i
      secs = (60 * (x % 1)).to_i.to_s.rjust(2, '0')
      "#{mins}:#{secs} min/mi"
    end
  end

  def numberOfComponentsInPickerView(picker_view)
    1
  end

  def pickerView(picker_view, numberOfRowsInComponent: component)
    if picker_view == @layout.get(:distance_picker)
      distance_picker_values.size
    else
      pace_picker_values.size
    end
  end

  def pickerView(picker_view, viewForRow: row, forComponent: component, reusingView: old_view)
    (old_view || DistancePickerView.new).tap do |asdf|
      if picker_view == @layout.get(:distance_picker)
        asdf.label.text = distance_picker_values[row]
      elsif picker_view == @layout.get(:pace_picker)
        asdf.label.text = pace_picker_values[row]
      end
      asdf
    end
  end

  def pickerView(picker_view, didSelectRow: row, inComponent: component)
    if picker_view == @distance_picker
      @layout.get(:button_distance_value).setTitle(distance_picker_values[row], forState: UIControlStateNormal)
    elsif picker_view == @pace_picker
      @layout.get(:button_pace_value).setTitle(pace_picker_values[row], forState: UIControlStateNormal)
    end
  end
end

=begin
class SimpleLayout < MK::Layout
  attr_accessor :controller

  @sent = false

  def people
    #@ab ||= AddressBook::AddrBook.new
    #@ab.people

    # mock it for now
    [{:first_name => "Imran", :last_name => "Khoja", :phones => [{:value => '+16172302397', :label => 'Mobile'}]},
     {:first_name => "Emily", :last_name => "Little", :phones => [{:value => '+16172302397', :label => 'Mobile'}]}]
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
      slide_vert(@label_contact, top(:text_field_contact))
      slide_vert(@text_field_contact, top(:text_field_contact))
      slide_vert(@table_invites, top(:table_invites))
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

  def update_mode
    if @mode == :runners
      @button_runners.backgroundColor = UIColor.grayColor
      @button_meeting.backgroundColor = UIColor.whiteColor
      @map.hide
      @label_contact.show
      @text_field_contact.show
      @table_invites.show
      @button_drop.hide
    else
      @button_runners.backgroundColor = UIColor.whiteColor
      @button_meeting.backgroundColor = UIColor.grayColor
      @button_drop.hide
      @label_contact.hide
      @text_field_contact.hide
      @table_invites.hide
      @map.show
      @button_drop.show
    end
  end

  def layout
    # these variables are poorly named
    @state = :default
    @mode = :runners # possible modes: :runners, :meeting

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
    @distance_picker.tap do |p|
      p.delegate = @distance_picker.dataSource = self
      p.selectRow(9, inComponent: 0, animated: false)
      p.hide
    end

    @pace_picker = add UIPickerView, :distance_picker do
      background_color UIColor.whiteColor
      frame [[0,64 + 30 + 30 + 30],['100%','100%']]
    end
    @pace_picker.tap do |p|
      p.delegate = @pace_picker.dataSource = self
      p.selectRow(16, inComponent: 0, animated: false)
      p.hide
    end

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
      title "5.0 mi"
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
      b.setTitle("9:00 min/mi", forState:UIControlStateNormal)
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
      @mode = :runners
      update_mode
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
      @mode = :meeting
      update_mode
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
      v.hide
      v.delegate = self
    end

    @table_invites = add UITableView, :table_invites do
      frame [[0,top(:table_invites)],['100%', '100%']]
    end
    @table_invites.tap do |t|
      #t.backgroundView.backgroundColor = UIColor.grayColor
      t.delegate = t.dataSource = self
    end

    # highlight runners/meeting
    update_mode


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
    @invite.tap do |b|
    end
    @invite.on(:touch) {
      puts "invite"
      @state = :default
      slide_elements
      send_invites
    }

    background_color UIColor.whiteColor
  end

  def invite_params
    first_names = []
    last_names = []
    phones = []
    people.each_with_index do |x,i|
      first_names << x[:first_name]
      last_names << x[:last_name]
      phones << x[:phones][0][:value]
    end
    {
      "from" => {
        "first_name" => "Ben",
        "last_name" => "Miller",
        "phone" => "+16178602901"
      },
      "info" => {
        "miles" => "5.5",
        "time" => "5:45 PM",
        "pace" => "9:00"
      },
      "first_names" => first_names,
      "last_names" => last_names,
      "phones" => phones
    }
  end

  def send_invites
    client = AFMotion::Client.build("https://api.parse.com/") do
      request_serializer :json

      header "X-Parse-Application-Id", Config.parse_app_id
      header "X-Parse-REST-API-Key", Config.parse_api_key
    end

    if @sent
      invite_controller = self.controller.navigationController.delegate.invite_controller
      self.controller.navigationController.pushViewController(invite_controller, animated: true)
    else
      ap invite_params
      if Config.production?
        client.post("1/functions/hello", invite_params) do |result|
          ap result.object if result.object
        end
      else
        puts "in development mode, skipping sms"
      end
    end

    @sent = !@sent
  end


  # picker view methods (ran into memory issues when trying to do this in a delegate class)
  def distance_picker_values
    @distance_picker_values ||= 0.5.step(20, 0.5).to_a.map{|x| "#{x} mi"}
  end

  def pace_picker_values
    @pace_picker_values ||= 5.step(30, 0.25).to_a.map do |x|
      mins = x.to_i
      secs = (60 * (x % 1)).to_i.to_s.rjust(2, '0')
      "#{mins}:#{secs} min/mi"
    end
  end

  def numberOfComponentsInPickerView(picker_view)
    1
  end

  def pickerView(picker_view, numberOfRowsInComponent: component)
    if picker_view == @distance_picker
      distance_picker_values.size
    else
      pace_picker_values.size
    end
  end

  def pickerView(picker_view, viewForRow: row, forComponent: component, reusingView: old_view)
    (old_view || DistancePickerView.new).tap do |asdf|
      if picker_view == @distance_picker
        asdf.label.text = distance_picker_values[row]
      elsif picker_view == @pace_picker
        asdf.label.text = pace_picker_values[row]
      end
      asdf
    end
  end

  def pickerView(picker_view, didSelectRow: row, inComponent: component)
    if picker_view == @distance_picker
      @button_distance_value.setTitle(distance_picker_values[row], forState: UIControlStateNormal)
    elsif picker_view == @pace_picker
      @button_pace_value.setTitle(pace_picker_values[row], forState: UIControlStateNormal)
    end
  end

  # contact list stuff
  def textFieldShouldReturn(text_field)
    text_field.resignFirstResponder
  end

  def tableView(table_view, numberOfRowsInSection:section)
    people.size
  end

  def tableView(table_view, cellForRowAtIndexPath: index_path)
    row = index_path.row
    reuse_id = "table_id_#{row}"
    cell = table_view.dequeueReusableCellWithIdentifier(reuse_id) || begin
      UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier: reuse_id)
    end
    cell.textLabel.text = "#{people[row][:first_name]} #{people[row][:last_name]}"
    cell
  end

end
=end
