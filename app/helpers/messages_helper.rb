module MessagesHelper
  def check_active(roomid, id)
    if roomid.present?
      if roomid == id.to_s
        return "active"
      else
        return ""
      end
    else
      return ""
    end
  end
end
