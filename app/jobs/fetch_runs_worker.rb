class FetchRunsWorker

  def work
    User.where("token IS NOT NULL AND uid IS NOT NULL").each do |user|
      store = MapMyFitness::WorkoutStore.new(user.token)
      runs = store.workouts_for_last_14_days_by(user.uid)
      runs.each do |run|
        Run.where(:mmf_identifier => run.id).first_or_create(
                              user_id: User.find_by_uid(user.uid).id,
                              name: run.name,
                              distance: run.distance,
                              run_time: run.duration,
                              workout_datetime: run.started_at 
                             )
      end 
    end
  end

end
