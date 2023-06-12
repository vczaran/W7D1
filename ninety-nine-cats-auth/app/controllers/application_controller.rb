class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?
  before_action :require_logged_out

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def logged_in?
    !!@current_user
  end

  def login(user)
    session[:session_token] = user.reset_session_token!
  end

  def logout!

    if logged_in?
      @current_user.reset_session_token!
      session[:session_token] = nil
      @current_user = nil
   end

  end

  def require_logged_out
   redirect_to cats_url if logged_in?
  end
end
