class SessionsController < ApplicationController

  def create
    user_data = MapMyFitness::User.new(request.env["omniauth.auth"])
    @user = User.find_or_create_by_auth(user_data)
    session[:user_id] = @user.id
    @user.save!

    store = MapMyFitness::WorkoutStore.new(current_user.token)
    runs = store.workouts_for_last_14_days_by(current_user.uid)
    # puts runs.inspect
    runs.each do |run|
      Run.find_or_create_by_mmf_identifier(run.id,
              user_id: User.find_by_uid(current_user.uid).id,
              name: run.name,
              distance: run.distance,
              run_time: run.duration,
              workout_datetime: run.started_at
             )
    end
    
    redirect_to dashboard_path, notice: "You are logged in!"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "You are logged out!"
  end

end
