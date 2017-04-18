module SigninHelper
  def authenticate(email, password, remember_user = false)
    user = User.find_by(email: email)
    return false unless user
    password_hash = Digest::MD5::hexdigest(password)
    if user.password == password_hash
      [true,user]
    else
      [false]
    end
  end

  def log_in(user)
    session[:user_id] = user.id
    # session[:name] = "#{user.first_name} #{user.last_name}"
    # session[:email] = user.email
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete(:user_id)
    session.delete(:name)
    session.delete(:email)
    @current_user = nil
    # reset_cookie
  end

  # Remembers a user in a active session
  def set_cookie(user)
    cookies.signed[:email] = {value: user.email, expires: 30.days.from_now }
    cookies.signed[:password] = {value: user.password, expires: 30.days.from_now }
  end

  def reset_cookie
    cookies.signed[:email] = cookies.signed[:password] = nil if !cookies.signed[:email].empty? and !cookies.signed[:password].empty?
  end

end
