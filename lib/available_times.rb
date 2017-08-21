require_relative '../lib/period'
require_relative '../lib/available_time'

class AvailableTimes

  def initialize repository
    @repository = repository
  end

  def get from, to
    available_times = []
    busy_times = []
    busy_times = @repository.get_by_period(from, to)

    start = from
    while start <= to
      available_time = create_default_available_time(start)
      available_times << available_time
      available_time.split_by_busy_times(busy_times)
      start = start + 1
    end

    available_times
  end

  def create_default_available_time(start)
    period = Period.new(DateTime.new(2017, 01, 01, 00, 00, 00),
                        DateTime.new(2017, 01, 01, 23, 59, 59))
    periods = [period]
    available_time = AvailableTime.new(start, periods)
  end
end