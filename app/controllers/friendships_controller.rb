class FriendshipsController < ApplicationController

  def index
    @user = current_user
    @friendship = Friendship.new
  end

  def create
    unless valid_users.include?(friendship_params)
      flash.notice = "Could not find user: #{friendship_params}"
      redirect_to :back
    else
      current_user.add_friend(friendship_params)
      flash.notice = "Your request to #{friendship_params} has been sent!"
      redirect_to :back
    end
  end

  def destroy
    current_user.unfriend(friendship_params)
    flash.notice = "Your friendship with #{friendship_params} has been terminated!"
    redirect_to :back
  end

  def update
    current_user.approve_friend(friendship_params)
    redirect_to :back
  end

  private

  def friendship_params
    params.require(:friendship).require(:friend_name)
  end

end
