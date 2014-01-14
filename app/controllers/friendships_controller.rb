class FriendshipsController < ApplicationController

  def index
    @user = current_user
    @friendship = Friendship.new
  end

  def create
    if current_user.add_friend(friend)
      flash.notice = "Your request to #{friendship_params} has been sent!"
    else
       flash.notice = "Could not find user: #{friendship_params}"      
    end
    redirect_to :back
  end

  # def destroy
  #   if Friendship.cancel_between(current_user, friend)
  #     flash.notice = "Your friendship with #{friendship_params} has been terminated!"
  #   else
  #     flash.notice = "Sorry, friendship with #{friend.username} not found for #{current_user.username}"
  #   end
  #   redirect_to :back
  # end

  def update
    current_user.approve_friend(friend)
    redirect_to :back
  end

  def approve
    #current_user.approve_friend(friend)
    Friendship.approve(params[:id])
    redirect_to :back
  end

  def remove
    Friendship.remove(params[:id])
    flash.notice = "Your friendship has been terminated!"

    redirect_to :back

  end

  private

  def friendship_params
    params.require(:friendship).require(:friend_name)
  end

  def friend
    User.find_by(username: friendship_params)
  end

end
