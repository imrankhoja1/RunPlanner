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

    @layout.get(:button_runners).on(:touch) {
      @state = :default
      @layout.slide_elements(@state)
      @mode = :runners
      @layout.reflect_state(@state, @mode)
    }
    @layout.get(:button_meeting).on(:touch) {
      @state = :default
      @layout.slide_elements(@state)
      @mode = :meeting
      @layout.reflect_state(@state, @mode)
    }

    @layout.get(:button_drop).on(:touch) {
      @state = :default
      @layout.slide_elements(@state)
    }

    @layout.get(:invite).on(:touch) {
      @state = :default
      @layout.slide_elements(@state)
      #send_invites
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

  def layout

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
