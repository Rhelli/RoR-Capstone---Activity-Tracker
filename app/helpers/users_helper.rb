module UsersHelper
  def full_name
    "#{current_user.first_name} #{current_user.last_name}"
  end

  def gravatar_for(user)
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?d=identicon&s=400"
    image_tag(gravatar_url, alt: user.first_name.titleize, class: 'gravatar')
  end
end
