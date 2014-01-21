class InvitesController < ApplicationController

  def create
    User.send_friend_request_email(params[:email], current_user.username)
    
    flash.notice = "Your request to #{params[:email]} has been sent!"
    
    redirect_to :back
  end


end
