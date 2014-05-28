class TapController < UIViewController
  #def loadView
  #end

  def viewDidLoad
    super

    self.view.backgroundColor = UIColor.whiteColor

    # ask user for permission to access the address book
    ab = AddressBook::AddrBook.new
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
    # self.view(addSubview(@invite_picker))
    self.presentModalViewController(@invite_picker,animated:true)

    # AddressBook.pick do |person|
    #     if person
    #         puts person
    #     else
    #         puts "something went wrong"
    #     end
    # end

    status_bar_height = 20
    btn_height = 50
    selector_height = 35
    selectors_height = selector_height * 3
    small_button_height = 24
    map_height = 300
    send_run_cont_height = 70
    medium_btn_height = 40

    @label = UILabel.alloc.initWithFrame(CGRectZero)
    @label.text = "Plan Your Run"
    @label.color = UIColor.whiteColor
    @label.backgroundColor = UIColor.grayColor
    @label.textAlignment = NSTextAlignmentCenter
    @label.sizeToFit
    @label.bounds = CGRectMake(0, 0, self.view.frame.size.width, btn_height)
    @label.center = CGPointMake(self.view.frame.size.width / 2, status_bar_height + btn_height / 2)
    self.view.addSubview(@label)

    #add the date picker
    @run_time_selector_trigger = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    @run_time_selector_trigger.setTitle("Pick a Time:", forState: UIControlStateNormal)
    @run_time_selector_trigger.bounds = CGRectMake(0, 0, self.view.frame.size.width / 2, btn_height / 2)
    @run_time_selector_trigger.center = CGPointMake(self.view.frame.size.width / 2, status_bar_height + btn_height + btn_height / 2)
    #connects the presentDatePicker method to the button-press action
    @run_time_selector_trigger.addTarget(self, action:'presentDatePicker', forControlEvents:UIControlEventTouchUpInside)
    self.view.addSubview(@run_time_selector_trigger)

    #add the selector picker
    @run_distance_selector = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    @run_distance_selector.setTitle("Pick your Distance:", forState: UIControlStateNormal)
    @run_distance_selector.bounds = CGRectMake(0, 0, self.view.frame.size.width / 2, btn_height / 2)
    @run_distance_selector.center = CGPointMake(self.view.frame.size.width / 2, status_bar_height + btn_height + btn_height + btn_height / 2)
    
    #connects the presentDatePicker method to the button-press action
    @run_distance_selector.addTarget(self, action:'presentDistancePicker', forControlEvents:UIControlEventTouchUpInside)
    self.view.addSubview(@run_distance_selector)
   
    # @selectors_sv = UIView.alloc.initWithFrame(CGRectZero)
    # @selectors_sv.bounds = CGRectMake(0, 0, 200, 200)
    # @selectors_sv.center = CGPointMake(100, 100, 100, 100)
    # @selectors_sv.backgroundColor = UIColor.grayColor
    # self.view.addSubview(@selectors_sv)

    # @map_view = MKMapView.alloc.initWithFrame(CGRectZero)
    # @map_view.bounds = CGRectMake(0, 0, self.view.frame.size.width, map_height)
    # @map_view.center = CGPointMake(self.view.frame.size.width / 2, 43 + btn_height + selectors_height + (map_height / 2))
    # self.view.addSubview(@map_view)

    #add the selector options for runners / meeting point
    options = ["Runners","Meeting Point"]
    @option_selector = UISegmentedControl.alloc.initWithItems(options)
    @option_selector.center = CGPointMake(self.view.frame.size.width/2, 20 + btn_height + selectors_height + (small_button_height / 2))
    @option_selector.bounds = CGRectMake(0, 0, self.view.frame.size.width, btn_height / 2)
    @option_selector.addTarget(self, action: 'option_changed:', forControlEvents:UIControlEventValueChanged)
    @option_selector.selectedSegmentIndex = 0
    self.view.addSubview(@option_selector)

    @pin_label = UILabel.alloc.initWithFrame(CGRectZero)
    @pin_label.text = "Drop a Pin"
    @pin_label.color = UIColor.blackColor
    @pin_label.backgroundColor = UIColor.whiteColor
    @pin_label.textAlignment = NSTextAlignmentCenter
    @pin_label.sizeToFit
    @pin_label.bounds = CGRectMake(0, 0, self.view.frame.size.width, btn_height/2)
    @pin_label.center = CGPointMake(self.view.frame.size.width / 2, 32 + btn_height + selectors_height + btn_height / 2)
    self.view.addSubview(@pin_label)

    # @r_button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    # @r_button.setTitle("Runners", forState: UIControlStateNormal)
    # @r_button.bounds = CGRectMake(0, 0, self.view.frame.size.width / 2, btn_height / 2)
    # @r_button.center = CGPointMake(self.view.frame.size.width / 4, 20 + btn_height + selectors_height + (small_button_height / 2))
    # @r_button.setTitleColor(UIColor.whiteColor, forState: UIControlStateNormal)
    # @r_button.backgroundColor = UIColor.grayColor
    # self.view.addSubview(@r_button)
    
    # @m_button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    # @m_button.setTitle("Meeting Point", forState: UIControlStateNormal)
    # @m_button.bounds = CGRectMake(0, 0, self.view.frame.size.width / 2, btn_height / 2)
    # @m_button.center = CGPointMake(3 * self.view.frame.size.width / 4, 20 + btn_height + selectors_height + (small_button_height / 2))
    # @m_button.setTitleColor(UIColor.whiteColor, forState: UIControlStateNormal)
    # @m_button.backgroundColor = UIColor.grayColor
    # self.view.addSubview(@m_button)

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
    if (sender == @option_selector)
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