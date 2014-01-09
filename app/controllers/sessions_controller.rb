class SessionsController < ApplicationController

  def create
    @user = User.find_or_create_by_auth(request.env["omniauth.auth"])
    session[:user_id] = @user.id
    @user.save!    
    redirect_to dashboard_path, notice: "You are logged in!"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "You are logged out!"
  end

end
