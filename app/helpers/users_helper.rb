module UsersHelper
  def profil_pic(user)
    if user.user_detail.present?
      if user.user_detail.profile_pic.present?
        return user.user_detail.profile_pic.url
      else
        return "/profile_pic/user.png"
      end
    else
      return "/profile_pic/user.png"
    end
  end

  def cover_pic(user)
    if user.user_detail.present?
      if user.user_detail.cover_pic.present?
        return user.user_detail.cover_pic.url
      else
        return "http://gambolthemes.net/workwise_demo/HTML/images/resources/cover-img.jpg"
      end
    else
      return "http://gambolthemes.net/workwise_demo/HTML/images/resources/cover-img.jpg"
    end
  end

  def notify(content)
    if content.notify_type_id == 1
      "<a href='#{profile_path(content.sentby.id)}' title=''>#{content.sentby.name} </a> sent you a new Request."
    elsif content.notify_type_id == 2
      "<a href='#{profile_path(content.sentby.id)}' title=''>#{content.sentby.name} </a> accepted your Request."
    elsif content.notify_type_id == 3
      byebug
      "<a href='#{"http://0.0.0.0:3000/posts#" + (content.post.id).to_s}' title=''>#{content.sentby.name} </a> posted new post."
    elsif content.notify_type_id == 4
      "A post liked #{content.sentby.name}"
    elsif content.notify_type_id == 5
      "New comment form #{content.sentby.name}"
    end
  end

  def is_read(content)
    if content.is_read
      return "readed"
    else
      return "unread"
    end
  end
end
