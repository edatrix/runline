class Run < ActiveRecord::Base
  belongs_to :user

  validates :user_id, presence: true
  validates :distance, presence: true
  validates :run_time, presence: true
  validates :workout_datetime, presence: true

  def miles
    result = self.distance / 1609.34
    result.round(2)
  end

  def time_in_minutes
    Time.at(self.run_time).utc.strftime("%M:%S")
  end

  def longest_run_in_last_14_days
    longest_run = 0
    current_user.runs.each do |run|
      if run.distance > longest_run
        longest_run = run.distance
      end
      longest_run
    end
  end

  # def pace
    
  # end
end
