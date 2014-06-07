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

    @vf = ViewFactory.new(self.view.frame)

    # status bar
    @status_bar = @vf.status_bar
    self.view.addSubview(@status_bar)

    # top label
    @top_label = @vf.top_label
    self.view.addSubview(@top_label)

    # run time
    @run_time_button = @vf.run_time_button
    @run_time_button.addTarget(self, action: 'presentDatePicker', forControlEvents: UIControlEventTouchUpInside)
    self.view.addSubview(@run_time_button)

    # distance
    @distance_button = @vf.distance_button
    @distance_button.addTarget(self, action: 'presentDistancePicker', forControlEvents: UIControlEventTouchUpInside)
    self.view.addSubview(@distance_button)

    # pace
    @pace_button = @vf.pace_button
    self.view.addSubview(@pace_button)

    #add the selector options for runners / meeting point
    @option_selector = @vf.option_selector
    @option_selector.addTarget(self, action: 'option_changed:', forControlEvents: UIControlEventValueChanged)
    @option_selector.selectedSegmentIndex = 0
    self.view.addSubview(@option_selector)

    @pin_label = @vf.pin_label
    self.view.addSubview(@pin_label)

    @map_view = @vf.map_view
    #@map_view.hidden = true
    self.view.addSubview(@map_view)

    @invite_button = @vf.invite_button
    @invite_button_container = @vf.invite_button_container
    @invite_button_container.addSubview(@invite_button)
    self.view.addSubview(@invite_button_container)
  end

  def presentDatePicker
    UIView.animateWithDuration(0.5, animations: lambda {
      i = 0
      self.view.subviews.zip(ViewFactory::H2.keys).each do |x,k|
        x.center = @vf.center2(k, i)
        i += 1
      end
    })
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
  end

end
