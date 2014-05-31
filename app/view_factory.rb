class ViewFactory
  Dims = {
    status_bar_height: 20,
    btn_height: 50,
    selector_height: 35,
    selectors_height: 35*3,
    small_button_height: 24,
    map_height: 300,
    send_run_cont_height: 70,
    medium_btn_height: 40
  }

  def initialize(frame)
    @frame = frame
  end

  def top_view
    frame = UIView.alloc.initWithFrame(CGRectZero)
    frame.backgroundColor = UIColor.lightGrayColor
    frame.bounds = CGRectMake(0, 0, @frame.size.width, 300)
    frame.center = CGPointMake(@frame.size.width / 2, 200)
    frame
  end

  def top_label
    label = UILabel.alloc.initWithFrame(CGRectZero)
    label.text = "Plan Your Run"
    label.color = UIColor.whiteColor
    label.backgroundColor = UIColor.grayColor
    label.textAlignment = NSTextAlignmentCenter
    label.sizeToFit
    label.bounds = CGRectMake(0, 0, @frame.size.width, Dims[:btn_height])
    label.center = CGPointMake(@frame.size.width / 2, Dims[:status_bar_height] + Dims[:btn_height] / 2)
    label
  end

  def run_time_button
    top = Dims[:status_bar_height] + Dims[:btn_height] + Dims[:btn_height] / 2

    button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    button.setTitle("Pick a Time:", forState: UIControlStateNormal)
    button.bounds = CGRectMake(0, 0, @frame.size.width / 2, Dims[:btn_height] / 2)
    button.center = CGPointMake(@frame.size.width / 2, top)
    button
  end

  def distance_button
    btn_height = Dims[:btn_height]
    top = Dims[:status_bar_height] + btn_height + btn_height + btn_height / 2
    
    button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    button.setTitle("Pick your Distance:", forState: UIControlStateNormal)
    button.bounds = CGRectMake(0, 0, @frame.size.width / 2, btn_height / 2)
    button.center = CGPointMake(@frame.size.width / 2, top)
    button
  end

  def option_selector
    btn_height = Dims[:btn_height]
    top = 20 + btn_height + Dims[:selectors_height] + (Dims[:small_button_height] / 2)

    options = ["Runners", "Meeting Point"]
    selector = UISegmentedControl.alloc.initWithItems(options)
    selector.center = CGPointMake(@frame.size.width/2, top)
    selector.bounds = CGRectMake(0, 0, @frame.size.width, btn_height / 2)
    selector
  end

  def pin_label
    btn_height = Dims[:btn_height]

    label = UILabel.alloc.initWithFrame(CGRectZero)
    label.text = "Drop a Pin"
    label.color = UIColor.blackColor
    label.backgroundColor = UIColor.whiteColor
    label.textAlignment = NSTextAlignmentCenter
    label.sizeToFit
    label.bounds = CGRectMake(0, 0, @frame.size.width, btn_height/2)
    label.center = CGPointMake(@frame.size.width / 2, 32 + btn_height + Dims[:selectors_height] + btn_height / 2)
    label
  end

  def map_view
    map_view = MKMapView.alloc.initWithFrame(CGRectZero)
    map_view.bounds = CGRectMake(0, 0, @frame.size.width, Dims[:map_height])
    map_view.center = CGPointMake(@frame.size.width / 2, 43 + Dims[:btn_height] + Dims[:selectors_height] + (Dims[:map_height] / 2))
    map_view
  end

  def invite_button
    button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    button.setTitle("Send Run Invite", forState: UIControlStateNormal)
    button.bounds = CGRectMake(0, 0, @frame.size.width - 20, Dims[:medium_btn_height])
    button.center = CGPointMake(@frame.size.width / 2, Dims[:send_run_cont_height] / 2)
    button.setTitleColor(UIColor.whiteColor, forState: UIControlStateNormal)
    button.backgroundColor = UIColor.colorWithRed(0.169, green: 0.561, blue: 0.329, alpha: 1.0)
    button
  end

  def invite_button_container
    container = UIView.alloc.initWithFrame(CGRectZero)
    container.bounds = CGRectMake(0, 0, @frame.size.width, Dims[:send_run_cont_height])
    container.center = CGPointMake(@frame.size.width / 2, @frame.size.height - (Dims[:send_run_cont_height] / 2))
    container
  end

end
