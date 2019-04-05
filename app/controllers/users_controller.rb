class UsersController < ApplicationController
  def profile
    @user = User.find(params[:format])
    @friendlist = Friendlist.where(sender_id: @user.id).or(Friendlist.where(recipient_id: @user.id))
    # @is_requested = @friendlist.pluck(:recipient_id).include?(current_user.id) || @friendlist.pluck(:sender_id).include?(current_user.id)
    if current_user.present?
      is_send = Friendlist.find_by(sender_id: current_user.id, recipient_id: @user.id)
      is_receive = Friendlist.find_by(sender_id: @user.id, recipient_id: current_user.id)
      if is_send.present?
        @status = { is_accepted: is_send.is_accepted, is_send: true, is_receive: false, is_requested: true }
      elsif is_receive.present?
        @status = { is_accepted: is_receive.is_accepted, is_send: false, is_receive: true, is_requested: true }
      else
        @status = { is_accepted: false, is_send: false, is_receive: false, is_requested: false }
      end
    else
      flash[:notice] = { class: "error", message: "If you want to see others profile please login" }
      redirect_to login_path
    end
  end

  def edit
    @user = User.find(current_user.id)
  end

  def update
    user_detail = UserDetail.find_by_user_id(current_user.id)
    if user_detail.present?
      user = user_detail.update(profile_pic: params[:profile_pic], location: params[:location], designation: params[:designation])
    else
      user = UserDetail.create!(user_id: current_user.id, profile_pic: params[:profile_pic], location: params[:location], designation: params[:designation])
    end
    if user
      redirect_to profile_path(current_user.id)
    else
      render "edit"
    end
  end

  def add_friend
    recipient_id = params[:format]
    sender_id = current_user.id
    friendlist = Friendlist.new(sender_id: sender_id, recipient_id: recipient_id, is_accepted: false)
    if friendlist.save
      flash[:notice] = "Friend Added Successfully"
      redirect_to profile_path(recipient_id)
    else
      flash[:notice] = "Something went wrong"
    end
  end

  def confirm_request
    request = Friendlist.find_by(sender_id: params[:format], recipient_id: current_user.id)
    if request.update(is_accepted: true)
      flash[:notice] = "Request Accepted"
      redirect_to profile_path(params[:format])
    else
      flash[:notice] = "Try Again"
    end
  end

  def reject_request
    request = Friendlist.find_by(sender_id: params[:format], recipient_id: current_user.id)
    if request.destroy
      flash[:notice] = "Request Rejected"
      redirect_to profile_path(params[:format])
    else
      flash[:notice] = "Try Again"
    end
  end

  def cancle_request
    request = Friendlist.find_by(sender_id: current_user.id, recipient_id: params[:format])
    if request.destroy
      flash[:notice] = "Request Cancled"
      redirect_to profile_path(params[:format])
    else
      flash[:notice] = "Try Again"
    end
  end

  def delete_friend
    ids = [params[:format], current_user.id]
    byebug
    friend = Friendlist.where(sender_id: ids).find_by(recipient_id: ids)
    if friend.destroy
      flash[:notice] = "Unfriend Successfull"
      redirect_to profile_path(params[:format])
    else
      flash[:notice] = "Try Again"
    end
  end

  def notification
    @notifications = Notification.where(receivedby_id: current_user.id, is_read: false)
  end
end
