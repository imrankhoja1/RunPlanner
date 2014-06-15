class DistancePickerView < UIView
  attr_reader :label

  def init
    super
    addSubview(@label = UILabel.new)
    @label.frame = [[0,0],[320,32]]
    sizeToFit
    @label.font = UIFont.fontWithName("Helvetica", size: 24)
    @label.textAlignment = NSTextAlignmentCenter
    self
  end
end
