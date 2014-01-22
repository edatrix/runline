class Formatting
  def self.format_seconds_for_views(total_seconds)
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
end
