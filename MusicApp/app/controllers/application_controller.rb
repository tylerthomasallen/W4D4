class ApplicationController < ActionController::Base
  # login(user)
  def login(user)
    session[:session_token] = user.reset_session_token!
    @current_user = user # allows us to logut
  end

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end


  def logged_in?
    !!current_user # if there is no current_user, no one is logged in
  end

  def require_login
    redirect_to 'login page, session/new' unless logged_in?
  end


  def logout
    current_user.reset_session_token! # reset session_token on user
    session[:session_token] = nil # reset session_token on cookie
  end
end
