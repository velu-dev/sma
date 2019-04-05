class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment: params[:comment], user_id: current_user.id, post_id: params[:post_id])
    if @comment.save
      @friendlist = Friendlist.where(sender_id: current_user.id, is_accepted: true).or(Friendlist.where(recipient_id: current_user.id, is_accepted: true))
      @friendlist.map do |friend|
        notify_to = current_user.id != friend.sender_id ? friend.sender_id : friend.recipient_id
        notification = Notification.create(sentby_id: current_user.id, receivedby_id: notify_to, post_id: params[:post_id], notify_type_id: 5, comment_id: @comment.id, is_read: false)
      end

      render @comment
    else
      flash[:notice] = "Something went wrong please try again"
      flash[:color] = "invalid"
    end
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def comments_count
    id = params[:id]
    post_count = Post.find(id)
    render json: post_count.comments.count
  end

  def destroy
    comment = Comment.find(params[:id])
    if comment.destroy
      flash[:notice] = "Comment deleted"
    else
      flash[:notice] = "Something went wrong please try again"
      flash[:color] = "invalid"
    end
  end
end
