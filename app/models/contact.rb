class Contact
  attr_accessor :first_name, :last_name, :phone
  attr_accessor :state

  def initialize(first_name, last_name, phone)
    @first_name = first_name
    @last_name = last_name
    @phone = phone

    @state = :unselected
  end

  def toggle
    @state == :selected ? unselect : select
  end

  def select
    @state = :selected
  end

  def unselect
    @state = :unselected
  end
end
