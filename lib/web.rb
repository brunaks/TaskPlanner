require 'sinatra'
require 'json'
require_relative './add_task_use_case'
require_relative './one_time_task'
require_relative './fake_task_repository'
require_relative './list_tasks_use_case'
require 'date'

task_repository = FakeTaskRepository.new

get '/tasks' do
  list_tasks = ListTasksUseCase.new task_repository
  list_tasks.list.to_json
end

post '/tasks' do
  request.body.rewind
  body = request.body.read
  json = JSON.parse body
  add_task = AddTaskUseCase.new task_repository
  add_task.add(OneTimeTask.new(json["name"], DateTime.parse(json["deadline"])))
  puts task_repository.all
  redirect '/tasks'
end