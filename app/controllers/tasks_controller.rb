class TasksController < ApplicationController
  def create
    @task = Task.create(task_params)
    if @task.save
      redirect_to folder_path(@task.folder_id)
    else
      flash[:error] = 'The task title cannot be empty :('
      redirect_to folder_path(@task.folder_id)
    end
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to folder_path(@task.folder_id)
    else
      redirect_to root_path
    end
  end

  private

  def task_params
    params.require(:task).permit(:title, :done, :folder_id, :deadline)
  end
end
