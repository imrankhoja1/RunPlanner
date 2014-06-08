class UIViewWithDelegate < UIView

  attr_accessor :controllerDelegate

  def initWithFrame(frame, andDelegate: delegate)
    self.initWithFrame(frame)
    self.controllerDelegate = delegate
    self
  end

end
