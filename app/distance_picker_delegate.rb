class DistancePickerDelegate
  def initialize
  end

  def numberOfComponentsInPickerView(picker_view)
    3
  end

  def pickerView(picker_view, numberOfRowsInComponent: component)
    10
  end

  def pickerView(picker_view, viewForRow: row, forComponent: component, reusingView: old_view)
    (old_view || DistancePickerView.new).tap do |asdf|
      asdf.label.text = "asdfasdf"
      asdf
    end
  end

  def pickerView(picker_view, didSelectRow: row, inComponent: component)
  end
end
