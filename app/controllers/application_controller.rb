class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= lookup_user
  end



  private

  def lookup_user
    if session[:user_id]
      User.find_by(id: session[:user_id]) || session[:user_id] = nil
    end
  end
end
