class DashboardsController < ApplicationController

  def index
    @user = current_user
  end

  def show
    @user = current_user
    @my_runs = current_user.runs
  end
end
