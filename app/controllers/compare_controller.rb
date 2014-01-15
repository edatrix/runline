class CompareController < ApplicationController

  def show
    @friend = current_user.total_approved_friends.find(params[:id]).first
    @my_runs = current_user.runs
    @friend_runs = @friend.runs
  end
end
