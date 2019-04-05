module UsersHelper
  def profil_pic(user)
    if user.user_detail.present?
      return user.user_detail.profile_pic.url
    else
      return "/profile_pic/user.png"
    end
  end

  def notify(content)
    if content.notify_type_id == 1
      "New Request"
    elsif content.notify_type_id == 2
      "Request Accepted"
    elsif content.notify_type_id == 3
      "New post from #{content.sentby.name}"
    elsif content.notify_type_id == 4
      "A post liked #{content.sentby.name}"
    elsif content.notify_type_id == 5
      "New comment form #{content.sentby.name}"
    end
  end
end
