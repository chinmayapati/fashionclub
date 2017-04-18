class User < ActiveRecord::Base

  before_save { self.email = email.downcase }
  before_save { self.password = Digest::MD5::hexdigest(password) }

  validates_presence_of :first_name, :last_name, :email, :password

  validates :first_name, length: {maximum: 50} #, message: 'Name should be between 5-50 Characters'}
  validates :last_name, length: {maximum: 50} #, message: 'Name should be between 5-50 Characters'}

  EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, length: {maximum: 60}, # message: 'Email should be between 5-20 characters'},
            format: {with: EMAIL_REGEX}, # message: 'Email address is invalid'},
            uniqueness: {case_sensitive: false}

  validates :password, length: {in: 6..20} #, message: 'Password should be 6-20 Characters'}

=begin

  # Returns a random token
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a user in database for use in persistent sessions
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

=end
end
