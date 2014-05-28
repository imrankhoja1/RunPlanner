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
    self.presentModalViewController(@invite_picker, animated: true)

    vf = ViewFactory.new(self.view.frame)

    @top_label = vf.top_label

    self.view.addSubview(@top_label)

    #add the date picker
    @run_time_button = vf.run_time_button
    @run_time_button.addTarget(self, action: 'presentDatePicker', forControlEvents: UIControlEventTouchUpInside)
    self.view.addSubview(@run_time_button)

    #add the selector picker
    @distance_button = vf.distance_button
    @distance_button.addTarget(self, action: 'presentDistancePicker', forControlEvents: UIControlEventTouchUpInside)
    self.view.addSubview(@distance_button)
   
    #add the selector options for runners / meeting point
    @option_selector = vf.option_selector
    @option_selector.addTarget(self, action: 'option_changed:', forControlEvents: UIControlEventValueChanged)
    @option_selector.selectedSegmentIndex = 0
    self.view.addSubview(@option_selector)

    @pin_label = vf.pin_label
    self.view.addSubview(@pin_label)

    @map_view = vf.map_view
    @map_view.hidden = true
    self.view.addSubview(@map_view)

    @invite_button = vf.invite_button
    @invite_button_container = vf.invite_button_container
    @invite_button_container.addSubview(@invite_button)
    self.view.addSubview(@invite_button_container)
  end

  def presentDatePicker
    controller = UIDatePicker.alloc.init
    self.view.addSubview(controller, animated: true)
  end

  def presentDistancePicker
    controller = UIPickerView.alloc.init
    controller.dataSource = self
    controller.delegate = self
    controller.transform = CGAffineTransformMakeScale(0.5, 0.5)
    self.view.addSubview(controller, animated: true)
  end

  def option_changed(sender)
    puts "option_changed #{sender}"
    if (sender == @option_selector)
      index = sender.selectedSegmentIndex
      puts "this is the index: #{index}"
      if (index == 1)
        @map_view.hidden = false
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
  def pickerView(pickerView, numberOfRowsInComponent: component)
    20
  end

  def pickerView(pickerView, titleForRow: row, forComponent: component)
    "#{0.5 + row*0.5} mi"
  end
end
