module PostsHelper
  def time_calculation(post_time)
    result = ((Time.now.localtime - post_time.to_time) / 1.day.to_i).round.days if Time.now.localtime - post_time.to_time > 1.day.to_i
    result = ((Time.now.localtime - post_time.to_time) / 1.hour.to_i).round.hours if Time.now.localtime - post_time.to_time > 1.hour.to_i && Time.now.localtime - post_time.to_time < 1.day.to_i

    result = ((Time.now.localtime - post_time.to_time) / 1.minute.to_i).round.minutes if Time.now.localtime - post_time.to_time > 1.minute.to_i && Time.now.localtime - post_time.to_time < 1.hour.to_i
    result
  end
end
