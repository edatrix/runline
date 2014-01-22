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
    Formatting.format_seconds_for_views(self.run_time)
  end

  def mile_pace_in_minutes
    Formatting.format_seconds_for_views((self.run_time / self.miles))
  end

  def format_date
    workout_datetime.to_time.strftime("%a, %m/%d/%y")
  end


end
