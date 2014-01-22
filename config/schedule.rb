

every 1.day, :at => '4:30 am' do
  rake "runline:enqueue_runs_worker"
end

every 1.minute do
  rake "runline:enqueue_runs_worker"
  puts "Enqueueing job"
end

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end
