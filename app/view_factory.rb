class ViewFactory
  H = {
    status_bar: 20,
    top_label: 50,
    run_time_button: 30,
    distance_button: 30,
    pace_button: 30,
    selector_height: 35,
    selectors_height: 35*3,
    small_button_height: 24,
    map_height: 300,
    send_run_cont_height: 70,
    medium_btn_height: 40,
    btn_height: 50
  }

  def initialize(frame)
    @frame = frame
  end

  def top(id, n)
    H.to_a.first(n).reduce(0){|sum,x| sum + x[1]} + H[id] / 2
  end

  def rect(id)
    CGRectMake(0, 0, @frame.size.width, H[id])
  end

  def center(id, n)
    CGPointMake(@frame.size.width / 2, top(id, n))
  end

  def top_label
    label = UILabel.alloc.initWithFrame(CGRectZero)
    label.text = "Plan Your Run"
    label.color = UIColor.whiteColor
    label.backgroundColor = UIColor.grayColor
    label.textAlignment = NSTextAlignmentCenter
    label.sizeToFit
    label.bounds = rect(:top_label)
    label.center = center(:top_label, 1)
    label
  end

  def picker_button(title, id, n)
    button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    button.setTitle(title, forState: UIControlStateNormal)
    button.bounds = rect(:run_time_button)
    button.center = center(id, n)
    button
  end

  def run_time_button
    picker_button("Pick a Time:", :run_time_button, 2)
  end

  def distance_button
    picker_button("Pick your Distance:", :distance_button, 3)
  end

  def pace_button
    picker_button("Pick your Pace:", :pace_button, 4)
  end

  def option_selector
    btn_height = H[:btn_height]
    top = 20 + btn_height + H[:selectors_height] + (H[:small_button_height] / 2)

    options = ["Runners", "Meeting Point"]
    selector = UISegmentedControl.alloc.initWithItems(options)
    selector.center = CGPointMake(@frame.size.width/2, top)
    selector.bounds = CGRectMake(0, 0, @frame.size.width, btn_height / 2)
    selector
  end

  def pin_label
    btn_height = H[:btn_height]

    label = UILabel.alloc.initWithFrame(CGRectZero)
    label.text = "Drop a Pin"
    label.color = UIColor.blackColor
    label.backgroundColor = UIColor.whiteColor
    label.textAlignment = NSTextAlignmentCenter
    label.sizeToFit
    label.bounds = CGRectMake(0, 0, @frame.size.width, btn_height/2)
    label.center = CGPointMake(@frame.size.width / 2, 32 + btn_height + H[:selectors_height] + btn_height / 2)
    label
  end

  def map_view
    map_view = MKMapView.alloc.initWithFrame(CGRectZero)
    map_view.bounds = CGRectMake(0, 0, @frame.size.width, H[:map_height])
    map_view.center = CGPointMake(@frame.size.width / 2, 43 + H[:btn_height] + H[:selectors_height] + (H[:map_height] / 2))
    map_view
  end

  def invite_button
    button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    button.setTitle("Send Run Invite", forState: UIControlStateNormal)
    button.bounds = CGRectMake(0, 0, @frame.size.width - 20, H[:medium_btn_height])
    button.center = CGPointMake(@frame.size.width / 2, H[:send_run_cont_height] / 2)
    button.setTitleColor(UIColor.whiteColor, forState: UIControlStateNormal)
    button.backgroundColor = UIColor.colorWithRed(0.169, green: 0.561, blue: 0.329, alpha: 1.0)
    button
  end

  def invite_button_container
    container = UIView.alloc.initWithFrame(CGRectZero)
    container.bounds = CGRectMake(0, 0, @frame.size.width, H[:send_run_cont_height])
    container.center = CGPointMake(@frame.size.width / 2, @frame.size.height - (H[:send_run_cont_height] / 2))
    container
  end

end
