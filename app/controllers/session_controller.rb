# frozen_string_literal: true

# Session Controller
class SessionController < ApplicationController
  skip_before_action :require_login, only: %i[login create]
  def login; end

  def create
    user = User.find_by_username(params[:username])
    if user&.authenticate(params[:password])
      sign_in user
      redirect_to root_path
    else
      flash[:notice] = if user.nil?
                         t('no_user')
                       else
                         t('wrong_pass')
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
