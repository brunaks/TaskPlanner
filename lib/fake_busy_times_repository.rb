
class FakeBusyTimesRepository

  def initialize
    @periods = []
  end

  def add period
    @periods << period
  end

  def get_by_period from, to
    @periods.select do |period|
      period.from <= to && period.to >= from
    end
  end

end