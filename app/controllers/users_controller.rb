class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :check_access, only: %i[ show edit update destroy] # редирект если current_user не админ и не set_user
  before_action :stay_admin, only: :destroy # нельзя удалить аккаунт админа
  skip_before_action :require_login, only: %i[create new]
  # добавить проверку на админа для users, админ должен иметь доступ ко всему
  # запретить дефолтным юзерам index, проверять users/id + users/id/edit (как с folder'ами)

  # GET /users or /users.json
  def index
    redirect_to root_path unless current_user.id == 6
    @folders = Folder.where(user_id: current_user.id)
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
    @folders = Folder.where(user_id: current_user.id)
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        sign_in @user
        format.html { redirect_to root_path, notice: t('welcome') }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    @folders = Folder.where(user_id: current_user.id)
      if @user.update(user_params)
        redirect_to user_url(@user), notice: t('user_was_updated')
      elsif !current_user.nil?
        flash[:error] = 'The task title and deadline cannot be empty :('
        # redirect_to user_url(@user) , status: :unprocessable_entity
        render :show, status: :unprocessable_entity
      else 
        redirect_to new_user_path, status: :unprocessable_entity
      end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: t('user_was_destroyed') }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:username, :password, :password_confirmation, :email)
    end

    def check_access
      redirect_to root_path if (current_user.id != 6)&&(current_user != set_user)
    end

    def stay_admin
      redirect_to user_path, alert: t('uradmin') if current_user.id == 6
    end
end
