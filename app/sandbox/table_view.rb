class TableViewController < UITableViewController
  def viewDidLoad
    super

    self.title = "Alphabet"

    @table = UITableView.alloc.initWithFrame(self.view.bounds)

    @table.dataSource = self

    self.view.addSubview @table

    @rows = ["A", "B", "C", "D"]
  end

  def tableView(tableView, numberOfRowsInSection: section)
    @rows.count
  end

  def tableView(tableView, cellForRowAtIndexPath: index)
    style = UITableViewCellStyleDefault

    cell = UITableViewCell.alloc.initWithStyle(style, reuseIdentifier: "asdf")
    cell.tintColor = UIColor.grayColor
    cell.textLabel.text = "asdf"
    cell.contentView.backgroundColor = UIColor.grayColor
    #view = UILabel.alloc.initWithFrame(CGRectZero)
    
    #view.text = "asdf"
    #cell.contentView.addSubview(view)
    #cell.textLabel.text = "Sup"
    #cell.contentView.bounds = CGRectMake(0, 0, self.view.frame.size.width, 100)
    #cell.contentView.centCGRectMake(self.view.frame.size.width / 2, 100)
    puts "INDEX: #{index}"
    cell
  end

  def tableView
    @table
  end
end
