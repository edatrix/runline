class SessionsController < ApplicationController

  def create
    user_data = MapMyFitness::User.new(request.env["omniauth.auth"])
    @user = User.find_or_create_by_auth(user_data)
    session[:user_id] = @user.id
    @user.save!

    # store = MapMyFitness::WorkoutStore.new(current_user.token)
    # runs = store.workouts_by(current_user.uid)
    # runs.each do |run|
    #   Run.new(
    #           user_id: User.find_by_uid(current_user.uid).id,
    #           distance: 900,
    #           name: run.name,
    #           run_time: run.duration,
    #           workout_datetime: run.starts_at
    #          )
    # end
    
    redirect_to dashboard_path, notice: "You are logged in!"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "You are logged out!"
  end

end
