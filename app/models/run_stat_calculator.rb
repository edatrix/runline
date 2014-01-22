class RunStatCalculator
  class << self
    def total_average_mile_pace_for(user)
      total_seconds = 0
      user.runs.each do |run|
        total_seconds += run.run_time
      end
      total_distance = 0
      user.runs.each do |run|
        total_distance += run.miles
      end
      Formatting.format_seconds_for_views(total_seconds / user.total_distance_in_miles)
    end

    def pace_for(user)
      total_seconds = 0
      user.runs.each do |run|
        total_seconds += run.run_time
      end
      total_distance = 0
      user.runs.each do |run|
        total_distance += run.miles
      end
      total_seconds/total_distance 
    end

    def compare_total_average_mile_pace_for(user, friend)
      if user.pace > friend.pace
        diff = user.pace - friend.pace
        "Your average mile is #{Formatting.format_seconds_for_views(diff)} slower than #{friend.username}'s"
      else
        diff = friend.pace - user.pace
        "Your average mile is #{Formatting.format_seconds_for_views(diff)} faster than #{friend.username}'s"
      end
    end

    def total_distance_in_miles_for(user)
      distance = 0
      user.runs.each do |run|
        distance += run.miles
      end
      distance.round(2)    
    end

    def fastest_run_for(user)
      user.runs.min_by { |run| (run.run_time / run.distance.to_f)}
    end

    def fastest_mile_pace_for(user)
      user.fastest_run.mile_pace_in_minutes
    end

    def longest_run_for(user)
      runs_by_distance = user.runs.sort! { |run| run.distance }
      runs_by_distance.first
    end
  end
end
