
class AddTaskUseCase
  def initialize task_repository
    @task_repository = task_repository
  end

  def add task
    @task_repository.add(task)
  end
end