class Invitation
  attr_accessor :sender, :start_time, :distance, :pace

  def initialize(sender, start_time, distance, pace)
    @sender = sender
    @start_time = start_time
    @distance = distance
    @pace = pace
  end

  def self.mock_list
    list = []
    sender = Contact.new("Imran", "Khoja", [{ value: "1 (617) 899-3929" }])
    list << new(sender, "3PM", "5.5mi", "7:30 min/mi")
    sender = Contact.new("Emily", "Little", [{ value: "555-555-5555" }])
    list << new(sender, "4:45PM", "3.5mi", "9:00 min/mi")
    list
  end
end
