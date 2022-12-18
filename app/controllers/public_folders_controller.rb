class PublicFoldersController < ApplicationController
  before_action :set_public_folder, only: %i[ show edit update destroy add_member ]
  before_action :set_owning_folders, only: %i[ index show new edit add_member ] # ownership for side bar mapping
  before_action :set_membering_folders, only: %i[ index show new edit add_member ] # membership for side bar mapping
  # add check_ownership for create, update, delete - only owner can change info - add flash[:notice] = 'You should be an owner to do that.'
  # add check_membership for show, edit, add_member - member can see info

  # GET /public_folders or /public_folders.json
  def index
  end

  # GET /public_folders/1 or /public_folders/1.json
  def show
    @task = Task.new # empty task for add task form
    @tasks = @public_folder.tasks # all tasks
    @colors = ActiveSupport::JSON::decode(@public_folder.colors) # color settings
    @members = ActiveSupport::JSON::decode(@public_folder.members) # member list
  end

  # GET /public_folders/new
  def new
    @public_folder = PublicFolder.new
    @colors = ActiveSupport::JSON::decode(@public_folder.colors)
    @members = ActiveSupport::JSON::decode(@public_folder.members)
  end

  # GET /public_folders/1/edit
  def edit # hidden field :new_member_id with value: ""
    @colors = ActiveSupport::JSON::decode(@public_folder.colors)
    @members = ActiveSupport::JSON::decode(@public_folder.members)
  end

  # POST /public_folders or /public_folders.json
  def create
    # @public_folder = PublicFolder.new(public_folder_params)

    # respond_to do |format|
    #   if @public_folder.save
    #     format.html { redirect_to public_folder_url(@public_folder), notice: "Public folder was successfully created." }
    #     format.json { render :show, status: :created, location: @public_folder }
    #   else
    #     format.html { render :new, status: :unprocessable_entity }
    #     format.json { render json: @public_folder.errors, status: :unprocessable_entity }
    #   end
    # end

    red = params[:public_folder][:red].to_i
    orange = params[:public_folder][:orange].to_i
    yellow = params[:public_folder][:yellow].to_i
    colors = { "red" => red, "orange" => orange, "yellow" => yellow }
    colors_json = ActiveSupport::JSON::encode(colors)

    @public_folder = PublicFolder.new(name: params[:public_folder][:name], user_id: params[:public_folder][:user_id], description: params[:public_folder][:description], colors: colors_json, members: params[:public_folder][:members])
    if (!(red < orange) || !(orange < yellow))
      flash[:error] = 'Wrong color settings.'
      redirect_to new_public_folder_path
      return
    end
    
    if @public_folder.save
      redirect_to public_folder_url(@public_folder), notice: "Folder was successfully created."
    else
      flash[:error] = 'Folder name cannot be empty.'
      redirect_to new_public_folder_path
    end
  end

  # PATCH/PUT /public_folders/1 or /public_folders/1.json
  def update
    # respond_to do |format|
    #   if @public_folder.update(public_folder_params)
    #     format.html { redirect_to public_folder_url(@public_folder), notice: "Public folder was successfully updated." }
    #     format.json { render :show, status: :ok, location: @public_folder }
    #   else
    #     format.html { render :edit, status: :unprocessable_entity }
    #     format.json { render json: @public_folder.errors, status: :unprocessable_entity }
    #   end
    # end

    red = params[:public_folder][:red].to_i
    orange = params[:public_folder][:orange].to_i
    yellow = params[:public_folder][:yellow].to_i
    colors = { "red" => red, "orange" => orange, "yellow" => yellow }
    colors_json = ActiveSupport::JSON::encode(colors)
    if (!(red < orange) || !(orange < yellow))
      flash[:error] = 'Wrong color settings.'
      redirect_to edit_public_folder_path
      return
    end

    @members = ActiveSupport::JSON::decode(@public_folder.members) # array of current member names

    new_member_name = params[:public_folder][:new_member_name]
    if (!(User.find_by_username(new_member_name)) && (new_member_name != "")) || (new_member_name == current_user.username)
      flash[:error] = 'User to add not found.'
      redirect_to edit_public_folder_path
      return
    end

    if @members.include?(new_member_name)
      flash[:error] = 'User to add is already in member list.'
      redirect_to edit_public_folder_path
      return
    end

    p delete_member_name = params[:public_folder][:delete_member_name]
    if !@members.include?(delete_member_name) && delete_member_name != ""
      flash[:error] = 'User to delete is not in the list of members.'
      redirect_to edit_public_folder_path
      return
    end

    @members.append(new_member_name) unless new_member_name == "" # adding new member
    @members.delete(delete_member_name)
    members_json = ActiveSupport::JSON::encode(@members)

    if @public_folder.update(name: params[:public_folder][:name], user_id: params[:public_folder][:user_id], description: params[:public_folder][:description], colors: colors_json, members: members_json)
      redirect_to public_folder_url(@public_folder), notice: "Folder was successfully updated."
    elsif PublicFolder.find_by_name(params[:public_folder][:name])
      flash[:error] = 'Folder name already exists.'
      redirect_to edit_public_folder_path
    else
      flash[:error] = 'Folder name cannot be empty.'
      redirect_to edit_public_folder_path
    end
  end

  # DELETE /public_folders/1 or /public_folders/1.json
  def destroy
    @public_folder.destroy

    respond_to do |format|
      format.html { redirect_to public_folders_url, notice: "Public folder was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def add_member # view add_member.html.erb, submit method - post, hidden fields: :name, :description, COLORS... 
    @members = ActiveSupport::JSON::decode(@public_folder.members) #encoding JSON from members field # don't forget to add set_public_folder before action
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_public_folder
      @public_folder = PublicFolder.find(params[:id])
    end

    def set_owning_folders
      current_user.id
      @owning_folders = PublicFolder.where(user_id: current_user.id) # owning folders for side bar
    end

    def set_membering_folders # membering folders for side bar, array
      all_public_folders = PublicFolder.all
      p @membering_folders = all_public_folders.select{ |folder| ActiveSupport::JSON::decode(folder.members).include?(current_user.username) }
    end

    # Only allow a list of trusted parameters through.
    def public_folder_params
      params.require(:public_folder).permit(:name, :description, :colors, :members, :user_id) # colors, members - JSON
    end
end
