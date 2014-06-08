class AppController < UIViewController
  def viewDidLoad
    super

    self.view.backgroundColor = UIColor.whiteColor

    # ask user for permission to access the address book
    if AddressBook.authorized?
      puts "this app is authorized!"
    else
      puts "This app is not authorized!"
      AddressBook.request_authorization
    end

    @vf = ViewFactory.new(self.view.frame)

    # navigation bar
    self.title = "Plan Your Run"

    # status bar
    @status_bar = @vf.status_bar
    self.view.addSubview(@status_bar)

    @x = 0

    # # run time
    # @run_time_button = @vf.run_time_button
    # @run_time_button.addTarget(self, action: 'presentDatePicker', forControlEvents: UIControlEventTouchUpInside)
    # self.view.addSubview(@run_time_button)

    # # distance
    # @distance_button = @vf.distance_button
    # @distance_button.addTarget(self, action: 'presentDistancePicker', forControlEvents: UIControlEventTouchUpInside)
    # self.view.addSubview(@distance_button)

    # # pace
    # @pace_button = @vf.pace_button
    # self.view.addSubview(@pace_button)

    # f = self.view.frame
    # puts f.position.y

    f = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height)

    @table = UITableView.alloc.initWithFrame(f)
    self.view.addSubview @table

    # #add the selector options for runners / meeting point
    # @option_selector = @vf.option_selector
    # @option_selector.addTarget(self, action: 'option_changed:', forControlEvents: UIControlEventValueChanged)
    # @option_selector.selectedSegmentIndex = 0
    # self.view.addSubview(@option_selector)

    # @pin_label = @vf.pin_label
    # self.view.addSubview(@pin_label)

    # @map_view = @vf.map_view
    # #@map_view.hidden = true
    # self.view.addSubview(@map_view)

    @invite_button = @vf.invite_button
    @invite_button_container = @vf.invite_button_container
    @invite_button_container.addSubview(@invite_button)
    self.view.addSubview(@invite_button_container)

    @table.dataSource = self
    @table.delegate = self
    @data = ['Starts', 'Distance', 'Target Pace']
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    # return the UITableViewCell for the row
    @reuseIdentifier ||= "CELL_IDENTIFIER"

    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier) || begin
      UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:@reuseIdentifier)
    end
    cell.textLabel.text = @data[indexPath.row]

    cell
  end

  def tableView(tableView, numberOfRowsInSection: section)
    # return the number of rows
    @data.count
  end

  def tableView(tableView, heightForRowAtIndexPath: indexPath)
    # puts indexPath.row
    # if indexPath.row == 0
    #   return 20
    # elsif indexPath.row == 1
    #   return 50
    # else
    #   return 100
    # end
    return 50
  end

  def tableView(tableView, didSelectRowAtIndexPath: indexPath)
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    to_delete = @data.include? "Hey!"
    @data.delete ("Hey!")
    tableView.numberOfRowsInSection(0)
    cell = @table.cellForRowAtIndexPath(indexPath)

    UIView.animateWithDuration(0.5, animations: lambda {

      tableView.deleteRowsAtIndexPaths([@adding_at], withRowAnimation: UITableViewRowAnimationFade) if to_delete && @adding_at
      @new_index = NSIndexPath.indexPathForRow(indexPath.row+1, inSection: 0)
      tableView.numberOfRowsInSection(0)
      if @new_index.row < 4
        @data.insert(@new_index.row, "Hey!")
      else
        @data << "Hey!"
      end

      @table.cellForRowAtIndexPath(@new_index)
      puts @data
      # NSIndexPath* newIndexPath = [NSIndexPath indexPathForRow:oldIndexPath.row+1 inSection:oldIndexPath.section];
      tableView.insertRowsAtIndexPaths([@new_index], withRowAnimation: UITableViewRowAnimationTop)
      # @table.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimationTop)
      # frame = cell.frame
      # frame.size.height = cell.frame.size.height * 2
      # cell.frame = frame
      # cell.rowHeight = 200
      # cell.frame.size.height = cell.frame.size.height * 2
    })
    @adding_at = @new_index
  end

  def presentDatePicker
    UIView.animateWithDuration(0.5, animations: lambda {
      i = 0
      self.view.subviews.zip(ViewFactory::H2.keys).each do |x,k|
        x.center = @vf.center2(k, i)
        i += 1
      end
    })
  end

  def presentDistancePicker
    controller = UIPickerView.alloc.init
    controller.dataSource = self
    controller.delegate = self
    controller.transform = CGAffineTransformMakeScale(0.5, 0.5)
    self.view.addSubview(controller, animated: true)
  end

  def option_changed(sender)
    puts "option_changed #{sender}"
  end

end
