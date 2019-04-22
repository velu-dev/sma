class AuthsController < ApplicationController
  def signin
  end

  def create
    if params[:password] == params[:repeat_password]
      user = User.create(name: params[:name], password: params[:password], email: params[:email], mobile: params[:mobile])
      if user
        flash[:notice] = "Sign Up Successfully"
        redirect_to login_path
      else
        render "signup"
      end
    else
      flash[:notice] = "Password should not be match"
      render "signup"
    end
  end

  def signup
  end

  def verify
  end

  def login_auth
    username = params[:username]
    password = params[:password]
    if username.split("").include? "@"
      user = User.find_by_email(username)
    else
      user = User.find_by_mobile(username)
    end
    if user && match_password(params[:password], user)
      otp = rand.to_s[2..7]
      session[:user_id] = user.id
      # UserMailer.send_mail(user.email, otp).deliver_now!
      flash[:notice] = "User loging in check your mail"
      flash[:color] = "success"
      redirect_to posts_path
    else
      flash[:notice] = "Invalid Username or Password"
      flash[:color] = "invalid"
      render "signin"
    end
  end

  def match_password(login_pass, user)
    user.password == BCrypt::Engine.hash_secret(login_pass, user.salt)
  end

  def forgot_pass
  end

  def reset_pass
  end

  def pass_reset
    user = User.find(current_user.id)
    if match_password(params[:old_pass], current_user)
      if params[:new_pass] == params[:confirm_pass]
        current_user.update(password: params[:new_pass])
        flash[:notice] = "Password reset successfully login again"
        redirect_to auths_logout_path
      else
        flash[:notice] = "New password and confirm password is wrong"
        render "reset_pass"
      end
    else
      flash[:notice] = "Your Old password is wrong"
      render "reset_pass"
    end
  end

  def find_account
    user = User.find_by(name: "user 3", email: "user3@user.com")
    if user.present?
      password = SecureRandom.hex(4)
      user.update(password: password)
      flash[:notice] = "Your password is #{password}"
      render "forgot_pass"
    else
      flash[:notice] = "Given data not match any records"
      render "forgot_pass"
    end
  end

  def logout
    session[:user_id] = nil
    current_user = nil
    redirect_to posts_path
  end
end
