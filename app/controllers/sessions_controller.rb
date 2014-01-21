class SessionsController < ApplicationController

  def create
    user_data = MapMyFitness::User.new(request.env["omniauth.auth"])
    @user = User.find_or_create_by_auth(user_data)
    @user.update_attributes(token: user_data.token)
    session[:user_id] = @user.id
    @user.save!

    store = MapMyFitness::WorkoutStore.new(current_user.token)
    runs = store.workouts_by_user_in_last_days(current_user.uid, 14)
    runs.each do |run|
      Run.where(:mmf_identifier => run.id).first_or_create(
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
