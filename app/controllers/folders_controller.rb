class FoldersController < ApplicationController
  before_action :set_folder, only: %i[ show edit update destroy ]
  before_action :check_ownership, only: %i[ show edit update destroy ]

  # GET /folders or /folders.json
  def index
    @folders = Folder.where(user_id: current_user.id)
  end

  # GET /folders/1 or /folders/1.json
  def show
    @folders = Folder.where(user_id: current_user.id)
    @task = Task.new
    @tasks = @folder.tasks
    @colors = ActiveSupport::JSON::decode(@folder.colors)
  end

  # GET /folders/new
  def new
    @folders = Folder.where(user_id: current_user.id)
    @folder = Folder.new
    @colors = ActiveSupport::JSON::decode(@folder.colors)
  end

  # GET /folders/1/edit
  def edit
    @folders = Folder.where(user_id: current_user.id)
    @colors = ActiveSupport::JSON::decode(@folder.colors)
  end

  # POST /folders or /folders.json
  def create
    red = params[:folder][:red].to_i
    orange = params[:folder][:orange].to_i
    yellow = params[:folder][:yellow].to_i
    colors = { "red" => red, "orange" => orange, "yellow" => yellow }
    colors_json = ActiveSupport::JSON::encode(colors)
    @folder = Folder.new(name: params[:folder][:name], user_id: params[:folder][:user_id], description: params[:folder][:description], colors: colors_json)
    if (!(red < orange) || !(orange < yellow))
      flash[:error] = 'Wrong color settings.'
      redirect_to new_folder_path
      return
    end
    
    if @folder.save
      redirect_to folder_url(@folder), notice: "Folder was successfully created."
      # format.json { render :show, status: :created, location: @folder }
    else
      flash[:error] = 'Folder name cannot be empty.'
      redirect_to new_folder_path
      # format.json { render json: @folder.errors, status: :unprocessable_entity }
    end
  end

  # PATCH/PUT /folders/1 or /folders/1.json
  def update
    # colors
    red = params[:folder][:red].to_i
    orange = params[:folder][:orange].to_i
    yellow = params[:folder][:yellow].to_i
    colors = { "red" => red, "orange" => orange, "yellow" => yellow }
    colors_json = ActiveSupport::JSON::encode(colors)
    if (!(red < orange) || !(orange < yellow))
      flash[:error] = 'Wrong color settings.'
      redirect_to edit_folder_path
      return
    end

    if @folder.update(name: params[:folder][:name], user_id: params[:folder][:user_id], description: params[:folder][:description], colors: colors_json) # change to my_params or add to folder_params colors
      redirect_to folder_url(@folder), notice: "Folder was successfully updated."
      # format.json { render :show, status: :ok, location: @folder }
    else
      flash[:error] = 'Folder name cannot be empty.'
      redirect_to edit_folder_path
      # format.json { render json: @folder.errors, status: :unprocessable_entity }
    end
  end

  # DELETE /folders/1 or /folders/1.json
  def destroy
    @folder.destroy

    respond_to do |format|
      format.html { redirect_to folders_url, notice: "Folder was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_folder
      @folder = Folder.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def folder_params
      params.require(:folder).permit(:name, :user_id, :description) # :colors!!
    end

    def check_ownership
      unless @folder.user_id == current_user.id
        redirect_to root_path
      end
    end
end
