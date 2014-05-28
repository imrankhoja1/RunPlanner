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

end
