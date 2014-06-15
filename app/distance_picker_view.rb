class DistancePickerView < UIView
  attr_reader :label

  def init
    super
    addSubview(@label = UILabel.new)
    @label.text = "asdf"
    @label.frame = [[0,0],[100,25]]
    @label.backgroundColor = UIColor.grayColor
    self
  end
end
