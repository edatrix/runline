class Run < ActiveRecord::Base
  belongs_to :user

  validates :user_id, presence: true
  validates :distance, presence: true
  validates :run_time, presence: true
  validates :workout_datetime, presence: true

  def miles
    result = self.distance / 1609.34
    result.to_s[0..-15]
  end

  def time_in_minutes
    Time.at(self.run_time).utc.strftime("%M:%S")
  end

  # def pace
    
  # end
end
