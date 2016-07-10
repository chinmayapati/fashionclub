class UsersController < ApplicationController
  layout 'users'

  def signin
    @current_view = 'Sign In'
  end

  def signup
    @current_view = 'Sign Up'
  end

  def recover
    @current_view = 'Recover'
  end
end
