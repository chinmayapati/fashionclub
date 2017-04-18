class SigninController < ApplicationController
  def index
    if logged_in?
      redirect_to root_url
    elsif !cookies.signed[:email].nil? and !cookies.signed[:password].nil?
      authenticate cookies.signed[:email], cookies.signed[:password], true
    else
      @error = ""
    end
  end

  def create
    user_auth = authenticate params[:signin][:email] , params[:signin][:password]
    if user_auth[0]
      @error = ""
      log_in user_auth[1] # set session
      redirect_to '/'
    else
      @error = 'Invalid Email/Password Combination'
      render 'index'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

  def show
  end

end
