class AuthsController < ApplicationController
  def signin
  end

  def create
    if params[:password] == params[:repeat_password]
      user = User.create(name: params[:name], email: params[:email], password: params[:password], mobile: params[:mobile])
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
    if user && user.password == password
      otp = rand.to_s[2..7]
      session[:user_id] = user.id
      user.update(otp: otp)
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

  def logout
    session[:user_id] = nil
    current_user = nil
    redirect_to posts_path
  end
end
