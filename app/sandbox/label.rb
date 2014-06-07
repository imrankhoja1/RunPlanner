class SandboxView1Controller < UIViewController

  def viewDidLoad
    label = UILabel.alloc.initWithFrame(CGRectZero)
    label.text = "Hello world"
    label.backgroundColor = UIColor.blueColor
    label.bounds = CGRectMake(0, 0, self.view.frame.size.width, 100)
    label.center = CGPointMake(self.view.frame.size.width / 2, 100)

    self.view.addSubview(label)
  end

end
