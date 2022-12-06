class SessionController < ApplicationController
  skip_before_action :require_login, only: %i[login create]
  def login
  end
  
  def create
    user = User.find_by_username(params[:username])
    if user&.authenticate(params[:password])
      sign_in user
      redirect_to root_path
    else
      if user.nil?
        flash[:notice] = 'Такого пользователя не существует.'
      else
        flash[:notice] = 'Неверный пароль.'
      end
      p flash[:notice]
      redirect_to session_login_path
    end
  end

  def logout
    sign_out
    redirect_to session_login_path
  end
end
