module ApplicationHelper
  def user_avatar_for(user, size: 100, **options)
    image_tag(user.gravatar_url(size: size), **options)
  end
end
