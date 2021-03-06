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

    set_left_item

    NSNotificationCenter.defaultCenter.addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
    NSNotificationCenter.defaultCenter.addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
  end

  def set_left_item
    right_item = self.navigationItem.rightBarButtonItem
    left_item = UIBarButtonItem.alloc.initWithTitle("Options", style: right_item.style, target: self, action: "pop_to_options")
    self.navigationItem.setLeftBarButtonItem(left_item)
  end

  def pop_to_options
    navigationController.popToRootViewControllerAnimated(true)
  end

  def keyboardWillShow(notification)
    NSLog("keyboardWillShow")
    #@state = :contact_field_selected
    #@layout.reflect_state(@state, @mode)
    elements = [@layout.get(:table_invites), @layout.get(:text_field_contact)]
    animate_with_keyboard(notification, elements, true)
  end

  def keyboardWillHide(notification)
    NSLog("keyboardWillHide")
    #@state = :default
    #@layout.reflect_state(@state, @mode)
    elements = [@layout.get(:table_invites), @layout.get(:text_field_contact)]
    animate_with_keyboard(notification, elements, false)
  end

  def animate_with_keyboard(notification, elements, up)
    info = notification.userInfo
    curve = info.valueForKey(UIKeyboardAnimationCurveUserInfoKey).intValue
    duration = info.valueForKey(UIKeyboardAnimationDurationUserInfoKey).doubleValue
    bounds = info.objectForKey(UIKeyboardFrameBeginUserInfoKey).CGRectValue
    @layout.to_front(:label_contact)
    @layout.to_front(:text_field_contact)
    UIView.beginAnimations(nil, context: nil)
    UIView.setAnimationCurve(curve)
    UIView.setAnimationDuration(duration)
      label_contact = @layout.get(:label_contact)
      text_field_contact = @layout.get(:text_field_contact)
      table_invites = @layout.get(:table_invites)
      if up
        @old_contact_label_rect = label_contact.frame
        @old_contact_field_rect = text_field_contact.frame
        @old_contact_table_rect = table_invites.frame
        new_contact_label_rect = new_rect(label_contact, bounds, 0.0)
        new_contact_field_rect = new_rect(text_field_contact, bounds, 0.0)
        new_contact_table_rect = new_rect(table_invites, bounds, @layout.h1)
      else
        new_contact_label_rect = @old_contact_label_rect
        new_contact_field_rect = @old_contact_field_rect
        new_contact_table_rect = @old_contact_table_rect
      end

      label_contact.setFrame(new_contact_label_rect)
      text_field_contact.setFrame(new_contact_field_rect)
      table_invites.setFrame(new_contact_table_rect)
    UIView.commitAnimations()
  end

  def new_rect(element, keyboard_bounds, offset)
    rect = element.frame
    CGRectMake(rect.origin.x, 64.0 + offset,
        rect.size.width, rect.size.height)
  end

  def nav_to_invite_page
    invite_list_controller = navigationController.delegate.invite_list_controller
    #navigationController.pushViewController(invite_controller, animated: true)
    navigationController.pushViewController(invite_list_controller, animated: true)
  end

  def init_buttons
    self.navigationItem.rightBarButtonItem = UIBarButtonItem.alloc.initWithTitle("Invites", style: UIBarButtonItemStylePlain, target: self, action: "nav_to_invite_page")

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

    @layout.get(:invite).on(:touch) {
      @state = :default
      @layout.slide_elements(@state)

      if FBSession.activeSession.isOpen
        RunSession.send(@contact_list.selected_contacts)
      else
        navigationController.popToRootViewControllerAnimated(true)
      end
    }
  end

  def set_delegates
    @layout.get(:table_invites).dataSource = @contact_list
    @layout.get(:table_invites).delegate = @contact_list

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
  end

  def locationManager(manager, didChangeAuthorizationStatus: status)
    return if status != 3 # CLAuthorizationStatus == 3
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
    if picker_view == @layout.get(:distance_picker)
      @layout.get(:button_distance_value).setTitle(distance_picker_values[row], forState: UIControlStateNormal)
    elsif picker_view == @layout.get(:pace_picker)
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
    cell.textLabel.text = "#{contacts[row].first_name} #{contacts[row].last_name}"
    cell
  end

  def mapView(map, viewForAnnotation: annotation)
    MKPinAnnotationView.alloc.initWithAnnotation(annotation, reuseIdentifier: 'pin')
  end

  def locationManager(manager, didUpdateToLocation: newLocation, fromLocation: oldLocation)
    #NSLog("Latitude = %@ Longitude = %@", newLocation.coordinate.latitude, newLocation.coordinate.longitude)
    #@layout.get(:map).region.center = newLocation.coordinate
    #RunSession.update_location_if_active(newLocation.coordinate)
  end
end
