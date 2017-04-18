module AccountsHelper

  def gravatar(email)
    url = "http://secure.gravatar.com/avatar/"
    email_hash = Digest::MD5::hexdigest(email)
    image_link = "#{url}#{email_hash}"
  end

end
