class MessagesController < ApplicationController
  def index
    @chat_rooms = ChatRoom.where(user_id: current_user.id).or(ChatRoom.where(second_user_id: current_user.id))
  end

  def show
    @group = ChatRoom.find(params[:id])
    @chat_rooms = ChatRoom.where(user_id: current_user.id).or(ChatRoom.where(second_user_id: current_user.id))
    render "index"
  end
end
