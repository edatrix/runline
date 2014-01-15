class UsersController < ApplicationController

  def index
    @user = current_user
  end

  def create
    
  end

  def update
    current_user.update_attributes(:email => params[:user][:email])
    flash.notice = "Your email has been updated!"
    redirect_to :back
  end

end
