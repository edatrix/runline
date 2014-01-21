class CompareController < ApplicationController

  def show
    @friend = find_current_friend(params[:id])
    unless current_user.runs.empty? || @friend.runs.empty?
      @my_runs = current_user.runs
      @friend_runs = @friend.runs
      @diff_miles = (current_user.total_distance_in_miles - @friend.total_distance_in_miles).round(2)
      @diff_pace = (current_user.pace - @friend.pace)
      @diff_longest_run = (current_user.longest_run.miles - @friend.longest_run.miles).round(2)
    end
  end

  def find_current_friend(id)
    current_friend = []
    current_user.total_approved_friends.each do |friend|
      if friend.id == id.to_i
        current_friend << friend
      end
      current_friend
    end
    current_friend.first
  end

end
