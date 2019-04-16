class PostsController < ApplicationController
  def index
    if current_user.present?
      @friendlist = Friendlist.where(sender_id: current_user.id, is_accepted: true).or(Friendlist.where(recipient_id: current_user.id, is_accepted: true))
      friends = @friendlist.pluck(:sender_id, :recipient_id).flatten.uniq
      @posts = []
      if friends.empty?
        @posts = Post.where(user_id: current_user.id).order(created_at: :desc)
      else
        @posts = Post.where(user_id: friends).order(created_at: :desc)
      end
    else
      @posts = Post.all.order(created_at: :desc)
    end
    # @posts = Post.all.order(created_at: :desc)
    @users = User.all
    @current_userliked_post = Like.where(user_id: current_user.id).pluck(:post_id) if current_user.present?
  end

  def destroy
    cmd = Comment.where(post_id: params[:id])
    cmd.delete_all if cmd.present?
    like = Like.where(post_id: params[:id])
    like.delete_all if like.present?
    post = Post.find(params[:id]).delete
    if Post
      flash[:notice] = "post deleted Successfully"
    else
      flash[:notice] = "Something went wrong please try again"
      flash[:color] = "invalid"
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def post_media
    post_media = PostMedium.new(media_type: params[:media].content_type, media: params[:media])
    if post_media.save
      render json: { status: true, data: post_media }
    else
      render json: { status: false }
    end
  end

  def delete_media
    post_media = PostMedium.find(params[:id])
    if post_media.destroy
      render json: { status: true }
    else
      render json: { status: false }
    end
  end

  def post_filter
    @posts = Post.where(" '#{params[:id]}' = ANY (tags)").order(created_at: :desc)
    @users = User.all
    @current_userliked_post = Like.where(user_id: current_user.id).pluck(:post_id) if current_user.present?
    render "index"
  end

  def create
    post = Post.new(location: params[:location], content: params[:content], user_id: current_user.id, tags: params[:tags].split(","))
    if post.save
      params[:media].map do |media|
        PostMedium.create(media_type: media.content_type, post_id: post.id, media: media)
      end
      @friendlist = Friendlist.where(sender_id: current_user.id, is_accepted: true).or(Friendlist.where(recipient_id: current_user.id, is_accepted: true))
      @friendlist.map do |friend|
        notify_to = current_user.id != friend.sender_id ? friend.sender_id : friend.recipient_id
        notification = Notification.create(sentby_id: current_user.id, receivedby_id: notify_to, post_id: post.id, notify_type_id: 3, is_read: false)
      end
      redirect_to posts_path
    else
      flash[:notice] = "Something went wrong please try again"
      flash[:color] = "invalid"
    end
  end

  def like
    is_liked = Like.find_by(post_id: params[:post_id], user_id: params[:user_id])
    if is_liked
      is_liked.delete
      like_count = Like.where(post_id: params[:post_id])
      render json: { is_like: false, like_count: like_count.count }
    else
      like = Like.new(user_id: params[:user_id], post_id: params[:post_id])
      if like.save
        @friendlist = Friendlist.where(sender_id: current_user.id, is_accepted: true).or(Friendlist.where(recipient_id: current_user.id, is_accepted: true))
        @friendlist.map do |friend|
          notify_to = current_user.id != friend.sender_id ? friend.sender_id : friend.recipient_id
          notification = Notification.create(sentby_id: current_user.id, receivedby_id: notify_to, post_id: params[:post_id], notify_type_id: 4, like_id: like.id, is_read: false)
        end

        like_count = Like.where(post_id: params[:post_id])
        flash[:notice] = "Liked Successfully"
        render json: { is_like: true, like_count: like_count.count }
      else
        format[:notice] = "Something went wrong"
      end
    end
  end
end
