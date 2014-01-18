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
    format_seconds_for_views(self.run_time)
  end

  def mile_pace_in_minutes
    format_seconds_for_views((self.run_time / self.miles))
  end

  def format_seconds_for_views(total_seconds)
    hours = (total_seconds / 3600).to_i
    minutes = ((total_seconds / 60) % 60).to_i.to_s
    seconds = (total_seconds % 60).round.to_s
    seconds = "0" + seconds if seconds.length == 1
    if hours >= 1
      minutes = "0" + minutes if minutes.length == 1
      "#{hours}:#{minutes}:#{seconds}"
    else
      "#{minutes}:#{seconds}"
    end
  end

  def format_date
    workout_datetime.to_time.strftime("%a, %m/%d/%y")
  end


end
