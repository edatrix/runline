class CompareController < ApplicationController

  def show
    @friend = current_user.total_approved_friends.find(params[:id]).first
    @my_runs = current_user.runs
    @friend_runs = @friend.runs
    @diff_miles = (current_user.total_distance_in_miles - @friend.total_distance_in_miles).round(2)
    @diff_pace = (current_user.pace - @friend.pace)
    @diff_longest_run = (current_user.longest_run.miles - @friend.longest_run.miles).round(2)
  end

end
