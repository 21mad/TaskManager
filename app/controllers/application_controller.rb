class ApplicationController < ActionController::Base
    include SessionHelper
    before_action :require_login

    def require_login
      redirect_to session_login_path unless signed_in?
    end
end
