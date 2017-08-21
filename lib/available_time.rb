require_relative '../lib/period'

class AvailableTime
  def initialize date, periods
    @date = date
    @periods = periods
  end

  def date
    @date
  end

  def periods
    @periods
  end

  def split_by_busy_times(busy_times)
    busy_times_for_date = get_busy_times_for_date(busy_times)
    busy_times_for_date.each do |busy_time|
      @periods = @periods.map do |period|
        period_before_busy_time = Period.new(period.from,busy_time.from - (1.0/86400.0))
        period_after_busy_time = Period.new(busy_time.to + (1.0/86400.0), period.to)
        [period_before_busy_time, period_after_busy_time]
      end.flatten
    end
  end

  def get_busy_times_for_date(busy_times)
    busy_times.select do |busy_time|
      busy_time.from <= @date && busy_time.to >= @date
    end
  end
end