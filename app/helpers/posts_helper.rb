module PostsHelper
  def time_calculation(post_time)
    if Time.now.localtime - post_time.to_time > 1.day.to_i
      return (((Time.now.localtime - post_time.to_time) / 1.day.to_i).round.days).to_s
    end
    if Time.now.localtime - post_time.to_time > 1.hour.to_i && Time.now.localtime - post_time.to_time < 1.day.to_i
      return (((Time.now.localtime - post_time.to_time) / 1.hour.to_i).round.hours).to_s
    end
    if Time.now.localtime - post_time.to_time > 1.minute.to_i && Time.now.localtime - post_time.to_time < 1.hour.to_i
      return (((Time.now.localtime - post_time.to_time) / 1.minute.to_i).round.minutes).to_s
    end
  end
end
