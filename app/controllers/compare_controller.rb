class CompareController < ApplicationController

  def show
    @friend = current_user.total_approved_friends.find(params[:id])
  end
end
