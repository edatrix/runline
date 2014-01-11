class FriendshipsController < ApplicationController

  def index
    @user = current_user
    @friendship = Friendship.new
  end

  def create
    current_user.add_friend(friendship_params)
    redirect_to :back
  end

  def destroy
    current_user.unfriend(friendship_params)
    redirect_to :back

  end

  private

  def friendship_params
    params.require(:friendship).require(:friend_name)
  end

end
