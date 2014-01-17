class HomePageController < ApplicationController

  before_filter :disable_nav

  def index
    if session[:user_id]
      redirect_to dashboard_path
    end
  end
end
