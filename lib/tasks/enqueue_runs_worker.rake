namespace :runline do 
  desc "Go fetch runs for all the users"
  task :enqueue_runs_worker do 
    Resque.new << FetchRunsWorker.new
    Rails.logger.info 'queue job'
  end
end
