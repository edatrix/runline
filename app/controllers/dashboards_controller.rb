class DashboardsController < ApplicationController

  def show
    @user = current_user
    @my_runs = current_user.runs
  end
  
end
