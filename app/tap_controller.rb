class TapController < UIViewController
  #def loadView
  #end

  def viewDidLoad
    super

    self.view.backgroundColor = UIColor.whiteColor

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

    @selectors_sv = UIView.alloc.initWithFrame(CGRectZero)
    @selectors_sv.bounds = CGRectMake(0, 0, 200, 200)
    @selectors_sv.center = CGPointMake(100, 100, 100, 100)
    @selectors_sv.backgroundColor = UIColor.grayColor
    #self.view.addSubview(@selectors_sv)

    @map_view = MKMapView.alloc.initWithFrame(CGRectZero)
    @map_view.bounds = CGRectMake(0, 0, self.view.frame.size.width, map_height)
    @map_view.center = CGPointMake(self.view.frame.size.width / 2, 20 + btn_height + selectors_height + (map_height / 2))
    self.view.addSubview(@map_view)

    @r_button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    @r_button.setTitle("Runners", forState: UIControlStateNormal)
    @r_button.bounds = CGRectMake(0, 0, self.view.frame.size.width / 2, btn_height / 2)
    @r_button.center = CGPointMake(self.view.frame.size.width / 4, 20 + btn_height + selectors_height + (small_button_height / 2))
    @r_button.setTitleColor(UIColor.whiteColor, forState: UIControlStateNormal)
    @r_button.backgroundColor = UIColor.grayColor
    self.view.addSubview(@r_button)
    
    @m_button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    @m_button.setTitle("Meeting Point", forState: UIControlStateNormal)
    @m_button.bounds = CGRectMake(0, 0, self.view.frame.size.width / 2, btn_height / 2)
    @m_button.center = CGPointMake(3 * self.view.frame.size.width / 4, 20 + btn_height + selectors_height + (small_button_height / 2))
    @m_button.setTitleColor(UIColor.whiteColor, forState: UIControlStateNormal)
    @m_button.backgroundColor = UIColor.grayColor
    self.view.addSubview(@m_button)

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

end
