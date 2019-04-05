class ApplicationController < ActionController::Base
  helper_method :current_user
  skip_before_action :verify_authenticity_token

  protected

  def authenticate_user
    if session[:is_login]
      # set current user object to @current_user object variable
      @current_user = User.find(session[:user_id])
      return true
    else
      redirect_to(:controller => "sessions", :action => "login")
      return false
    end
  end

  def save_login_state
    if session[:is_login]
      redirect_to(:controller => "posts", :action => "index")
      return false
    else
      return true
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
