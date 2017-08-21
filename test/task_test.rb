require 'minitest/autorun'
require 'date'
require_relative '../lib/one_time_task'
require_relative '../lib/add_task_use_case'
require_relative '../lib/list_tasks_use_case'
require_relative '../lib/fake_task_repository'

class Date
  def self.today= date
    @today = date
  end
  def self.today
    @today
  end
end

class TaskTest < MiniTest::Unit::TestCase
  def  test_task_overdue
    task = OneTimeTask.new 'Task 01', Date.new(2017, 01, 01)
    set_today Date.new 2017, 01, 02
    assert task.overdue?
  end

  def test_task_not_overdue
    task = OneTimeTask.new 'Task 01', Date.new(2017, 01, 01)
    set_today Date.new 2016, 12, 31
    assert_equal false, task.overdue?
  end

  def test_task_not_overdue_today
    task = OneTimeTask.new 'Task 01', Date.new(2017, 01, 01)
    set_today Date.new 2017, 01, 01
    assert_equal false, task.overdue?
  end

  def set_today date
    Date.today= date
  end
end

class AddTaskUseCaseTest < MiniTest::Unit::TestCase
  def test_add_one_task
    task_repository = FakeTaskRepository.new
    add_task = AddTaskUseCase.new task_repository
    add_task.add(OneTimeTask.new 'Task 01', Date.new(2017, 01, 01))
    tasks = ListTasksUseCase.new(task_repository).list
    assert_equal [OneTimeTask.new('Task 01', Date.new(2017, 01, 01))],
                 tasks
  end
end