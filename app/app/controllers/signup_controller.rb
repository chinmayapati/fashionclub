class SignupController < ApplicationController

  def index
    if logged_in?
      redirect_to root_url
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(signup_params)
    if @user.save
      redirect_to '/signin'
    else
      render 'index'
    end
  end

  def show
  end

  private
    def signup_params
      params.require(:user).permit(:first_name, :last_name, :email, :password)
    end
end
