class SessionsController < ApplicationController

  def create
    user_data = MapMyFitness::User.new(request.env["omniauth.auth"])
    @user = User.find_or_create_by_auth(user_data)
    session[:user_id] = @user.id
    @user.save!
    redirect_to dashboard_path, notice: "You are logged in!"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "You are logged out!"
  end

end
