class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user

  def disable_nav
    @disable_nav = true
  end

  def current_user
    @current_user ||= lookup_user
  end

  def valid_users
    User.all.collect {|user| user.username}
  end

  private

  def lookup_user
    if session[:user_id]
      User.find_by(id: session[:user_id]) || session[:user_id] = nil
    end
  end
end
