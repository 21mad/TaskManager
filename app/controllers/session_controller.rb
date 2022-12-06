class SessionController < ApplicationController
  def login
  end
  
  def create
    user = User.find_by_username(params[:username])
    if user&.authenticate(params[:password])
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
    sign_out # Наш метод выхода, описанный в хелпере
    redirect_to session_login_path
  end
end
