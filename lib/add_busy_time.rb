require_relative '../lib/period'

class AddBusyTime

  def initialize repository
    @repository = repository
  end

  def add from, to
    period = Period.new(from, to)
    @repository.add(period)
  end

end