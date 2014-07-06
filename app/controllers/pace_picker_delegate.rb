class PacePickerDelegate
  def initialize(controller)
    @controller = WeakRef.new(controller)
  end

  def pace_picker_values
    @pace_picker_values ||= 5.step(30, 0.25).to_a.map do |x|
      mins = x.to_i
      secs = (60 * (x % 1)).to_i.to_s.rjust(2, '0')
      "#{mins}:#{secs} min/mi"
    end
  end

  def numberOfComponentsInPickerView(picker_view)
    1
  end

  def pickerView(picker_view, numberOfRowsInComponent: component)
    pace_picker_values.size
  end

  def pickerView(picker_view, viewForRow: row, forComponent: component, reusingView: old_view)
    (old_view || DistancePickerView.new).tap do |asdf|
      asdf.label.text = pace_picker_values[row]
      asdf
    end
  end

  def pickerView(picker_view, didSelectRow: row, inComponent: component)
    @button_pace_value.setTitle(pace_picker_values[row], forState: UIControlStateNormal)
  end
end
