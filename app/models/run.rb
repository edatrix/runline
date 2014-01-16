class Run < ActiveRecord::Base
  belongs_to :user

  validates :user_id, presence: true
  validates :distance, presence: true
  validates :run_time, presence: true
  validates :workout_datetime, presence: true

  validates_uniqueness_of :workout_datetime

  # THINGS WE NEED:
  # FOR SINGLE RUN:
  # 1. distance in miles check
  # 2. time in hours, minutes, seconds (1:03:23)
  # 3. mile pace in minutes, seconds (6:35)

  # FOR ALL A USERS RUNS:
  # 1. total distance in miles over last 14 days
  # 2. average mile pace for all runs over last 14 days
  # 3. mile pace for fastest run in last 14 days
  # 4. longest run in miles in last 14 days


  def miles
    result = self.distance / 1609.34
    result.round(2)
  end

  def time_in_minutes
    Time.at(self.run_time).utc.strftime("%H:%M:%S")
  end

  def mile_pace_in_minutes
    pace = (self.run_time.to_f / 60) / self.miles
    pace.round(2)
  end

  def self.longest_run_for(id)
    all_runs_for(id).order(:distance).last
  end

  # def self.average_mile_pace_for(id)
  #   run_count = all_runs_for(id).count


  # end

  # def self.total_distance_for(id)
    
  # end

  # def self.all_runs_for(id)
  #   all.where(user_id: id)
  # end

  




  # def pace
    
  # end
end
