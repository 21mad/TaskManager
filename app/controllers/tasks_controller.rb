class TasksController < ApplicationController
  def index
  end

  def new
  end

  def show
  end
  
  def create
    @task = Task.create(task_params) # same as update
    if @task.save
      redirect_to folder_path(@task.folder_id) unless @task.folder_id.nil?
      redirect_to public_folder_path(@task.public_folder_id) unless @task.public_folder_id.nil?
    else
      flash[:error] = 'The task title and deadline cannot be empty :('
      redirect_to folder_path(@task.folder_id) unless @task.folder_id.nil?
      redirect_to public_folder_path(@task.public_folder_id) unless @task.public_folder_id.nil?
    end
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to "/folders/#{@task.folder_id}/#row#{@task.id}" unless @task.folder_id.nil? # !same as destroy
      redirect_to "/public_folders/#{@task.public_folder_id}" unless @task.public_folder_id.nil? # /#row#{@task.id} removed
    else
      redirect_to root_path
    end
  end

  def destroy
    @task = Task.find(params[:id])
    # my_path = folder_path(@task.folder_id) # changed my_path depenging on public_folder_id existance

    if !@task.folder_id.nil?
      my_path = folder_path(@task.folder_id)
    elsif !@task.public_folder_id.nil?
      my_path = public_folder_path(@task.public_folder_id)
      public_folder = PublicFolder.find(@task.public_folder_id)
      if (public_folder.user_id != current_user.id) && (@task.done_by != "")
        flash[:notice] = 'Only the owner can delete completed tasks.'
        redirect_to "/public_folders/#{@task.public_folder_id}"
        return
      end
    end

    if @task.destroy
      redirect_to my_path
    else
      redirect_to root_path
    end
  end

  private

  def task_params # migrated to FK folder_id can be null
    params.require(:task).permit(:title, :done, :folder_id, :deadline, :done_by, :public_folder_id) # added public folder id
  end
end
