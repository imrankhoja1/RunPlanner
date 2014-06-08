class ExampleView < UIViewWithDelegate

  TABLE_FRAME = CGRectMake(0,0,300,400)
  TABLE_ROW_HEIGHT = 30

  attr_accessor :table

  def initWithFrame(frame, andDelegate: delegate)
    super
    setupTable
    self
  end

  private

  def setupTable
    table = UITableView.alloc.initWithFrame(TABLE_FRAME)
    table.delegate = self.controllerDelegate
    table.dataSource = self.controllerDelegate
    self.addSubview table
  end

end

class ExampleController < UIViewController

  REUSE_IDENTIFIER = 'example'

  def viewDidLoad
    @data = [1,2,3,4]
    self.view = ExampleView.alloc.initWithFrame(view.frame)
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier)
    cell ||= UITableCell.alloc.initWithStyle(UITableViewCellStyleDefault,
    reuseIdentifier: REUSE_IDENTIFIER)
    cell.textLabel.text = @data[indexPath.row]
    cell
  end

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    self.navigationController.pushViewController(AnotherController.new, animated: true)
  end

  def tableView(tableView, numberOfRowsInSection: section)
    @data.count
  end

end
