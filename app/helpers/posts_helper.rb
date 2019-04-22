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

  def post_content_helper(post)
    if post.content.length < 300
      return "<p> #{post.content}</p>"
    else
      return "<p id='flex-content#{post.id}'>#{post.content.truncate(100, separator: " ")} <a id='expand-content#{post.id}'> Read more </a>
      </p><p id='full-content#{post.id}' class='animation fadeIn disable-content'>
      #{post.content}<a id='close-content#{post.id}'> Read less </a>
      </p>"
    end
  end
end
