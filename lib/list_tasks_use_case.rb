
class ListTasksUseCase
  def initialize task_repository
    @task_repository = task_repository
  end

  def list
    @task_repository.all
  end
end