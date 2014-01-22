require 'rake'
require 'resque/tasks'

namespace :runline do 
  desc "Go fetch runs for all the users"
  task :enqueue_runs_worker => :environment do 
    Resque.enqueue(FetchRunsWorker)
  end
end
