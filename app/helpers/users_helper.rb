module UsersHelper
  def full_name
    "#{current_user.first_name} #{current_user.last_name}"
  end

  def gravatar_for(user)
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?d=identicon&s=400"
    image_tag(gravatar_url, alt: user.first_name.titleize, class: 'gravatar')
  end

  def quick_stats_dots(count)
    count = 7 if count > 7
    inactive = '<i class="d-inline-block far fa-circle"></i>'
    active = '<i class="d-inline-block fas fa-circle"></i>'
    active_count = 7 - count
    printer = ''
    inactive_count = 7 - active_count
    inactive_count.times do
      printer.concat(active)
    end
    active_count.times do
      printer.concat(inactive)
    end
    printer.html_safe
  end
end
