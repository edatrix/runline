namespace :runline do 
  desc "Go fetch runs for all the users"
  task :enqueue_runs_worker do 
    Resque.enqueue(FetchRunsWorker)
    Rails.logger.info 'queue job'
  end
end
