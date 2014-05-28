class AppController < UIViewController
  def viewDidLoad
    super

    self.view.backgroundColor = UIColor.whiteColor

    # ask user for permission to access the address book
    if AddressBook.authorized?
        puts "this app is authorized!"
    else
        puts "This app is not authorized!"
        AddressBook.request_authorization
    end
    @invite_picker = ABPeoplePickerNavigationController.alloc.init
    @invite_picker.peoplePickerDelegate = self
    props = [KABPersonFirstNameProperty, KABPersonLastNameProperty, KABPersonPhoneMainLabel, KABPersonPhoneProperty]
    @invite_picker.displayedProperties = props
    self.presentModalViewController(@invite_picker,animated:true)

    status_bar_height = 20
    btn_height = 50
    selector_height = 35
    selectors_height = selector_height * 3
    small_button_height = 24
    map_height = 300
    send_run_cont_height = 70
    medium_btn_height = 40

    vf = ViewFactory.new(self.view.frame)

    label = vf.top_label

    self.view.addSubview(label)

    #add the date picker
    run_time_button = vf.run_time_button
    run_time_button.addTarget(self, action: 'presentDatePicker', forControlEvents: UIControlEventTouchUpInside)
    self.view.addSubview(run_time_button)

    #add the selector picker
    distance_button = vf.distance_button
    distance_button.addTarget(self, action: 'presentDistancePicker', forControlEvents: UIControlEventTouchUpInside)
    self.view.addSubview(distance_button)
   
    #add the selector options for runners / meeting point
    option_selector = vf.option_selector
    option_selector.addTarget(self, action: 'option_changed:', forControlEvents: UIControlEventValueChanged)
    option_selector.selectedSegmentIndex = 0
    self.view.addSubview(option_selector)

    pin_label = vf.pin_label
    self.view.addSubview(pin_label)

    @map_view = MKMapView.alloc.initWithFrame(CGRectZero)
    @map_view.bounds = CGRectMake(0, 0, self.view.frame.size.width, map_height)
    @map_view.center = CGPointMake(self.view.frame.size.width / 2, 43 + btn_height + selectors_height + (map_height / 2))

    @button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    @button.setTitle("Send Run Invite", forState: UIControlStateNormal)
    @button.bounds = CGRectMake(0, 0, self.view.frame.size.width - 20, medium_btn_height)
    #@button.sizeToFit
    @button.center = CGPointMake(self.view.frame.size.width / 2, send_run_cont_height / 2)
    #@button.cornerRadius = 30.0
    @button.setTitleColor(UIColor.whiteColor, forState: UIControlStateNormal)
    @button.backgroundColor = UIColor.colorWithRed(0.169, green: 0.561, blue: 0.329, alpha: 1.0)
    @button_container = UIView.alloc.initWithFrame(CGRectZero)
    @button_container.bounds = CGRectMake(0, 0, self.view.frame.size.width, send_run_cont_height)
    @button_container.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height - (send_run_cont_height / 2))
    #@button_container.backgroundColor = UIColor.whiteColor
    @button_container.addSubview(@button)
    self.view.addSubview(@button_container)
  end

  def presentDatePicker
    controller = UIDatePicker.alloc.init
    self.view.addSubview(controller, animated:true)
  end

  def presentDistancePicker
    controller = UIPickerView.alloc.init
    controller.dataSource = self
    controller.delegate = self
    controller.transform = CGAffineTransformMakeScale(0.5, 0.5)
    self.view.addSubview(controller, animated:true)
  end

  def option_changed(sender)
    puts "option_changed #{sender}"
    if (sender == option_selector)
        index = sender.selectedSegmentIndex
        puts "this is the index: #{index}"
        if (index == 1)
            self.view.addSubview(@map_view)
        end
        #add address book here
        if (index == 0)
            self.view(addSubview(@invite_picker))
        end
    end
  end
 # Necessary to implement these methods in order to be a datasource
  # - (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
  def numberOfComponentsInPickerView pickerView
    1 
  end

  # - (NSInteger)pickerView:(UIPickerView *)pickerView
  # numberOfRowsInComponent:(NSInteger)component;
  def pickerView(pickerView, numberOfRowsInComponent:component)
    20
  end

  def pickerView(pickerView, titleForRow:row, forComponent:component)
    "#{0.5+row*0.5} mi"
  end
end
