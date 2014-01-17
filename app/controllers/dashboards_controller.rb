class DashboardsController < ApplicationController

  def index
    @user = current_user

    store = MapMyFitness::WorkoutStore.new(current_user.token)
    runs = store.workouts_by(current_user.uid)
    runs.each do |run|
      Run.new(
              user_id: User.find_by_uid(current_user.uid).id,
              distance: 900,
              name: run.name,
              run_time: run.duration,
              workout_datetime: run.starts_at
             )
  end

  def show
    @user = current_user
  end
end
