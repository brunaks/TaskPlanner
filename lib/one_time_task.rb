class OneTimeTask
  def initialize name, deadline
    @name = name
    @deadline = deadline
  end

  def overdue?
    Date.today > @deadline
  end

  def to_json(*a)
    {name: @name, deadline: @deadline, overdue: overdue?}.to_json
  end

  def == other
    self.class == other.class &&
        self.name == other.name &&
        self.deadline == other.deadline
  end

  def name
    @name
  end

  def deadline
    @deadline
  end
end