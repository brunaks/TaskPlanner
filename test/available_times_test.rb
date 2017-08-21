require 'minitest/autorun'
require_relative '../lib/available_times'
require_relative '../lib/add_busy_time'
require_relative '../lib/fake_busy_times_repository'

class AvailableTimesTest < MiniTest::Unit::TestCase

  def setup
    @busy_times_repository = FakeBusyTimesRepository.new
  end

  def test_default_all_period_free
    available_times_use_case = AvailableTimes.new(@busy_times_repository)
    available_times = available_times_use_case.get(Date.new(2017, 01, 01), Date.new(2017, 01, 01))
    assert_equal(1, available_times.count)
    assert_equal(Date.new(2017, 01, 01), available_times[0].date)
    assert_equal(1, available_times[0].periods.count)
    assert_equal(DateTime.new(2017, 01, 01, 00, 00, 00), available_times[0].periods[0].from)
    assert_equal(DateTime.new(2017, 01, 01, 23, 59, 59), available_times[0].periods[0].to)
  end

  def test_set_busy_period_in_same_day
    add_busy_time = AddBusyTime.new(@busy_times_repository)
    add_busy_time.add(DateTime.new(2017,01,01,12,00,00),
                      DateTime.new(2017,01,01,13,00,00))
    available_times = AvailableTimes.new(@busy_times_repository).get(
                                         Date.new(2017, 01, 01),
                                         Date.new(2017, 01, 01))
    assert_equal(1, available_times.count)
    assert_equal(Date.new(2017, 01, 01), available_times[0].date)
    assert_equal(2, available_times[0].periods.count)

    assert_equal(DateTime.new(2017, 01, 01, 00, 00, 00), available_times[0].periods[0].from)
    assert_equal(DateTime.new(2017, 01, 01, 11, 59, 59), available_times[0].periods[0].to)

    assert_equal(DateTime.new(2017, 01, 01, 13, 00, 01), available_times[0].periods[1].from)
    assert_equal(DateTime.new(2017, 01, 01, 23, 59, 59), available_times[0].periods[1].to)
  end
end