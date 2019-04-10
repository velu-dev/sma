module ChatRoomsHelper
  def chat_room_description(room)
    if room.is_group
      return "This group created by #{room.first_user.name}"
    else
      return "Chat to "
    end
  end

  def chat_room_name(room)
    if room.is_group
      return room.room_name
    else
      return room.second_user.name
    end
  end
end
