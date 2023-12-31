module MangasHelper
  def refreshed_ago(last_refreshed)
    seconds_ago = (Time.current - last_refreshed).round
    minutes_ago = seconds_ago / 60
    hours_ago = minutes_ago / 60

    return "#{hours_ago} hours" if minutes_ago > 60
    return "#{minutes_ago} minutes" if seconds_ago > 60
    "#{seconds_ago} seconds"
  end
end
