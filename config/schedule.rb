

set :output, "#{path}/log/cron_log.log"

every 1.day, :at => '4:30 am' do
  rake "runline:enqueue_runs_worker"
end

every 2.hours do
  rake "runline:enqueue_runs_worker"
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
