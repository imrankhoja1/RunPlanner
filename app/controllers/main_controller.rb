class MainController < UIViewController

  def loadView
    @layout = MainLayout.new

    self.view = @layout.view
    self.title = Constants::AppTitle

    @contact_list = ContactList.new

    init_buttons
    set_delegates
    init_map

    @state = :default
    @mode = :runners
    @layout.reflect_state(@state, @mode)

    # logic for demo purposes
    @invitation_sent = false
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

      if @invitation_sent
        invite_controller = navigationController.delegate.invite_controller
        navigationController.pushViewController(invite_controller, animated: true)
      else
        RunSession.send(@contact_list.contacts)
      end

      @invitation_sent = !@invitation_sent
    }
  end

  def set_delegates
    @layout.get(:table_invites).dataSource = @contact_list

    @layout.get(:starts_picker).addTarget(self, action: 'update_date', forControlEvents: UIControlEventValueChanged)

    @layout.get(:distance_picker).delegate = self
    @layout.get(:distance_picker).dataSource = self
    @layout.get(:distance_picker).selectRow(9, inComponent: 0, animated: false)

    @layout.get(:pace_picker).delegate = self
    @layout.get(:pace_picker).dataSource = self
    @layout.get(:pace_picker).selectRow(16, inComponent: 0, animated: false)

    @layout.get(:text_field_contact).delegate = self
  end

  def init_map
    @location_manager = CLLocationManager.alloc.init
    @location_manager.delegate = self
    @location_manager.startUpdatingLocation
    @location_manager.purpose = "asdf"

    @layout.get(:map).region = MapKit::CoordinateRegion.new(@location_manager.location.coordinate, [3.5, 3.5])
    @layout.get(:map).shows_user_location = true
    @layout.get(:map).set_zoom_level(15)
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

  def textFieldShouldReturn(text_field)
    text_field.resignFirstResponder
  end

  def tableView(table_view, numberOfRowsInSection:section)
    @contact_list.contacts.size
  end

  def tableView(table_view, cellForRowAtIndexPath: index_path)
    contacts = @contact_list.contacts

    row = index_path.row
    reuse_id = "table_id_#{row}"
    cell = table_view.dequeueReusableCellWithIdentifier(reuse_id) || begin
      UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier: reuse_id)
    end
    cell.textLabel.text = "#{contacts[row][:first_name]} #{contacts[row][:last_name]}"
    cell
  end

  def mapView(map, viewForAnnotation: annotation)
    MKPinAnnotationView.alloc.initWithAnnotation(annotation, reuseIdentifier: 'pin')
  end

  def locationManager(manager, didUpdateToLocation: newLocation, fromLocation: oldLocation)
    puts "Latitude = #{newLocation.coordinate.latitude} Longitude = #{newLocation.coordinate.longitude}"
    #@layout.get(:map).region.center = newLocation.coordinate
  end
end
